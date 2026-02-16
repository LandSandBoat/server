-----------------------------------
-- Echad Ring Giveaway (常設配布)
--
-- 目的:
--   Port Jeuno に配布NPCを常設し、1キャラにつき1回だけエチャドリングを配布する。
--
-- 方針:
--   - 配布済み判定は charVar（DB永続）で保持する。
--   - インベントリ満杯などで配布に失敗した場合は、配布済みフラグを立てない。
--   - 既にエチャドリングを所持している場合は、配布済み扱いとしてフラグを立てる。
-----------------------------------

require('scripts/globals/npc_util')

xi = xi or {}
xi.events = xi.events or {}
xi.events.echadRingGiveaway = xi.events.echadRingGiveaway or {}
xi.events.echadRingGiveaway.entities = xi.events.echadRingGiveaway.entities or {}

local event = SeasonalEvent:new('EchadRingGiveaway')

-- 設定が存在する場合のみ参照（未設定なら常に有効）
xi.events.echadRingGiveaway.enabledCheck = function()
    if xi.settings == nil or xi.settings.main == nil then
        return true
    end

    local enabled = xi.settings.main.ECHAD_RING_GIVEAWAY_ENABLE
    if enabled == nil then
        return true
    end

    return enabled == 1
end

event:setEnableCheck(xi.events.echadRingGiveaway.enabledCheck)

local ZONE_ID = xi.zone.PORT_JEUNO
local CLAIM_VAR = '[ECHAD_RING_GIVEAWAY]CLAIMED'

-- HomePoint#1 の近く（Port Jeuno #1: 37.076 0.001 8.831）
local npcPos =
{
    rot = 192,
    x = 35.800,
    y = 0.001,
    z = 8.800,
}

local function onTrigger(player, npc)
    npc:facePlayer(player, true)

    local ID = zones[player:getZoneID()]

    -- 1キャラ1回のみ
    if player:getCharVar(CLAIM_VAR) == 1 then
        player:messageSpecial(ID.text.DRYEYES_3, xi.item.ECHAD_RING)
        return
    end

    -- 既に所持している場合は、配布済み扱いにして二重取得を防ぐ
    if player:hasItem(xi.item.ECHAD_RING) then
        player:setCharVar(CLAIM_VAR, 1)
        player:messageSpecial(ID.text.DRYEYES_3, xi.item.ECHAD_RING)
        return
    end

    -- インベントリが満杯なら何もせず終了（再挑戦可）
    if player:getFreeSlotsCount() == 0 then
        player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.ECHAD_RING)
        return
    end

    -- 配布（成功時のみフラグを立てる）
    if npcUtil.giveItem(player, xi.item.ECHAD_RING) then
        player:setCharVar(CLAIM_VAR, 1)
    end
end

xi.events.echadRingGiveaway.generateEntities = function()
    local zone = GetZone(ZONE_ID)
    if not zone then
        return
    end

    local npc = zone:insertDynamicEntity({
        objtype       = xi.objType.NPC,
        name          = 'Echad_Ring_Moogle',
        packetName    = 'Moogle',
        look          = 82,
        x             = npcPos.x,
        y             = npcPos.y,
        z             = npcPos.z,
        rotation      = npcPos.rot,
        onTrigger     = onTrigger,
        releaseIdOnDisappear = true,
    })

    if npc then
        table.insert(xi.events.echadRingGiveaway.entities, npc:getID())
    end
end

xi.events.echadRingGiveaway.showEntities = function(enabled)
    if enabled and #xi.events.echadRingGiveaway.entities == 0 then
        xi.events.echadRingGiveaway.generateEntities()
    end

    for _, entityID in pairs(xi.events.echadRingGiveaway.entities) do
        local entity = GetNPCByID(entityID)
        if entity then
            if enabled then
                entity:setStatus(xi.status.NORMAL)
            else
                entity:setStatus(xi.status.INVISIBLE)
            end
        end
    end

    if not enabled then
        xi.events.echadRingGiveaway.entities = {}
    end
end

event:setStartFunction(function()
    xi.events.echadRingGiveaway.showEntities(true)
end)

event:setEndFunction(function()
    xi.events.echadRingGiveaway.showEntities(false)
end)

return event
