-----------------------------------
--  NPC: Stale Draft
-- Area: Sacrarium
-- Notes: Used to spawn Swift Belt NM's
-----------------------------------
local ID = zones[xi.zone.SACRARIUM]
-----------------------------------
---@type TNpcEntity
local entity = {}

local swiftBeltNMs =
{
    { ID.mob.SWIFT_BELT_NM_OFFSET,     { [xi.race.HUME_M]   = true, [xi.race.HUME_F]   = true } }, -- Balor (hume)
    { ID.mob.SWIFT_BELT_NM_OFFSET + 1, { [xi.race.ELVAAN_M] = true, [xi.race.ELVAAN_F] = true } }, -- Luaith (elvaan)
    { ID.mob.SWIFT_BELT_NM_OFFSET + 2, { [xi.race.TARU_M]   = true, [xi.race.TARU_F]   = true } }, -- Lobais (tarutaru)
    { ID.mob.SWIFT_BELT_NM_OFFSET + 5, { [xi.race.MITHRA]   = true } },                            -- Caithleann (mithra)
    { ID.mob.SWIFT_BELT_NM_OFFSET + 6, { [xi.race.GALKA]    = true } },                            -- Indich (galka)
}

entity.onTrigger = function(player, npc)
    local hate = player:getCharVar('FOMOR_HATE')
    if hate < 8 then --hate lvl 1
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    elseif hate < 12 then
        player:messageSpecial(ID.text.START_GET_GOOSEBUMPS)
    elseif hate < 50 then
        player:messageSpecial(ID.text.HEART_RACING)
    elseif hate >= 50 then
        player:messageSpecial(ID.text.LEAVE_QUICKLY_AS_POSSIBLE)
    end
end

entity.onTrade = function(player, npc, trade)
    -- fomor codex
    if trade:hasItemQty(xi.item.FOMOR_CODEX, 1) and trade:getItemCount() == 1 then
        local draftOffset = npc:getID() - ID.npc.STALE_DRAFT_OFFSET
        local nmId = swiftBeltNMs[draftOffset + 1][1]
        local races = swiftBeltNMs[draftOffset + 1][2]
        local nm = GetMobByID(nmId)
        local race = player:getRace()
        local hate = player:getCharVar('FOMOR_HATE')

        if
            races[race] and
            nm and
            not nm:isSpawned() and
            hate >= 50
        then
            player:tradeComplete()
            player:setCharVar('FOMOR_HATE', 0)
            SpawnMob(nmId):updateClaim(player)
        else
            player:messageSpecial(ID.text.NOTHING_HAPPENS)
        end
    end
end

return entity
