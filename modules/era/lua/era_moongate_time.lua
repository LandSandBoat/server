-----------------------------------
-- Era Override: Ro'Meave Moongate Time
-- Opens only on Full Moon between 00:00 and 03:00
--
-- Source: https://ffxiclopedia.fandom.com/wiki/Moongate_Pass_Quest?oldid=1493013
-- Moongate Pass Quest did not change to 18:00 - 06:00 until the July 13, 2011 version update.
-----------------------------------
require('modules/module_utils')
require('scripts/globals/npc_util')
xi.module.ensureTable('xi.zones.RoMaeve')
-----------------------------------
local ID = zones[xi.zone.ROMAEVE]
-----------------------------------
local m = Module:new('era_moongate_time')

local function setMoongatesOpen(isOpen)
    local moongate1 = GetNPCByID(ID.npc.MOONGATE_OFFSET)
    local moongate2 = GetNPCByID(ID.npc.MOONGATE_OFFSET + 1)

    if not moongate1 or not moongate2 then
        return
    end

    local desiredState = isOpen and 1 or 0
    if moongate1:getLocalVar('romaeveActive') == desiredState then
        return
    end

    for i = ID.npc.MOONGATE_OFFSET, ID.npc.MOONGATE_OFFSET + 7 do
        local npc = GetNPCByID(i)
        if npc then
            npc:setAnimation(isOpen and xi.anim.OPEN_DOOR or xi.anim.CLOSE_DOOR)
        end
    end

    moongate2:setUntargetable(isOpen)
    moongate1:setUntargetable(isOpen)
    moongate1:setLocalVar('romaeveActive', desiredState)
end

m:addOverride('xi.zones.RoMaeve.Zone.onInitialize', function(zone)
    super(zone)
    setMoongatesOpen(false)
end)

m:addOverride('xi.zones.RoMaeve.Zone.onGameHour', function(zone)
    local vanadielHour = VanadielHour()
    local qm2 = GetNPCByID(ID.npc.BASTOK_7_1_QM)
    local newPosition = npcUtil.pickNewPosition(ID.npc.BASTOK_7_1_QM, ID.npc.BASTOK_7_1_QM_POS, false)

    local isOpenWindow =
        (getVanadielMoonCycle() == xi.moonCycle.FULL_MOON) and
        (vanadielHour >= 0 and vanadielHour < 3)
    setMoongatesOpen(isOpenWindow)

    if
        vanadielHour == 0 or
        vanadielHour == 6 or
        vanadielHour == 12 or
        vanadielHour == 18
    then
        if qm2 then
            npcUtil.queueMove(qm2, newPosition)
        end
    end
end)

return m