-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Magian Moogle (Orange Bobble)
-- Type: Magian Trials NPC (Weapon/Empyrean Armor)
-- !pos -11 2.453 118 64
-----------------------------------
require("scripts/globals/magiantrials")
-----------------------------------
local entity = {}

local eventIds =
{
    [1] = 10121,
    [2] = 10122,
    [3] = 10123,
    [4] = 10124,
    [5] = 10125,
    [6] = 10129,
}

entity.onTrade = function(player, npc, trade)
    if xi.settings.main.ENABLE_MAGIAN_TRIALS ~= 1 then
        return
    end

    xi.magian.magianOnTrade(player, npc, trade, xi.itemType.WEAPON, eventIds)
end

entity.onTrigger = function(player, npc)
    if xi.settings.main.ENABLE_MAGIAN_TRIALS ~= 1 then
        return
    end

    xi.magian.magianOnTrigger(player, npc, eventIds)
end

entity.onEventUpdate = function(player, csid, option)
    xi.magian.magianEventUpdate(player, csid, option, eventIds)
end

entity.onEventFinish = function(player, csid, option)
    xi.magian.magianOnEventFinish(player, csid, option, eventIds)
end

return entity
