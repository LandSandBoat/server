-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Magian Moogle (Orange Bobble)
-- Type: Magian Trials NPC (Weapon/Empyrean Armor)
-- !pos -11 2.453 118 64
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/RuLude_Gardens/IDs")
require("scripts/globals/magiantrials")
-----------------------------------
local entity = {}

entity.onTrade = function(player,npc,trade)
    if ENABLE_MAGIAN_TRIALS ~= 1 then
        return
    end

    tpz.magian.magianOrangeOnTrade(player,npc,trade)
end

entity.onTrigger = function(player,npc)
    if ENABLE_MAGIAN_TRIALS ~= 1 then
        return
    end

    tpz.magian.magianOrangeOnTrigger(player,npc)
end

entity.onEventUpdate = function(player,csid,option)
    tpz.magian.magianOrangeEventUpdate(player,itemId,csid,option)
end

entity.onEventFinish = function(player,csid,option)
    tpz.magian.magianOrangeOnEventFinish(player,itemId,csid,option)
end

return entity
