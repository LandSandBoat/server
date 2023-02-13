-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Magian Moogle (Orange Bobble)
-- Type: Magian Trials NPC (Weapons)
-- !pos -11 2.453 118 64
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if xi.settings.main.ENABLE_MAGIAN_TRIALS ~= 1 then
        return
    end

    xi.magian.magianOnTrade(player, npc, trade, xi.itemType.WEAPON, eventIds)
end

entity.onTrigger = function(player, npc)
    xi.magian.magianOnTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.magian.magianEventUpdate(player, csid, option, eventIds)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.magian.magianOnEventFinish(player, csid, option, eventIds)
end

return entity
