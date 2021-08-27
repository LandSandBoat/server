-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Magian Moogle (Blue Bobble)
-- Type: Magian Trials NPC (Relic Armor)
-- !pos -6.843 2.459 121.9 64
-----------------------------------
require("scripts/globals/magiantrials")
require("scripts/globals/status")
-----------------------------------
local entity = {}
local EVENT_IDS = {
    [2] = 10141,
    [3] = 10142,
    [4] = 10143,
    [5] = 10144,
    [6] = 10148,
}

entity.onTrade = function(player, npc, trade)
    if xi.settings.ENABLE_MAGIAN_TRIALS ~= 1 then
        return
    end

    xi.magian.magianOnTrade(player, npc, trade, xi.itemType.ARMOR, EVENT_IDS)
end

entity.onTrigger = function(player, npc)
    if xi.settings.ENABLE_MAGIAN_TRIALS ~= 1 then
        return
    end

    xi.magian.magianOnTrigger(player, npc, EVENT_IDS)
end

entity.onEventUpdate = function(player, csid, option)
    xi.magian.magianEventUpdate(player, csid, option, EVENT_IDS)
end

entity.onEventFinish = function(player, csid, option)
    xi.magian.magianOnEventFinish(player, csid, option, EVENT_IDS)
end

return entity
