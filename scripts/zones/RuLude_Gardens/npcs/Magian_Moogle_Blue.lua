-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Magian Moogle (Blue Bobble)
-- Type: Magian Trials NPC (Armor)
-- !pos -6.843 2.459 121.9 64
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if xi.settings.main.ENABLE_MAGIAN_TRIALS ~= 1 then
        return
    end

    xi.magian.magianOnTrade(player, npc, trade, xi.itemType.ARMOR, eventIds)
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
