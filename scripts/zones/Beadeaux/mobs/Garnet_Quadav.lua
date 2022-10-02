-----------------------------------
-- Area: Beadeaux (254)
--  Mob: Garnet Quadav
-- Notes: Bowl of Quadav Stew is a guaranteed steal with
--  Quest THE_TENSHODO_SHOWDOWN active
-----------------------------------
local ID = require("scripts/zones/Beadeaux/IDs")
require('scripts/globals/items')
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onSteal = function(player, target, ability, action)
    if
        player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_TENSHODO_SHOWDOWN) == QUEST_ACCEPTED and
        not player:hasItem(xi.items.BOWL_OF_QUADAV_STEW)
    then
        return xi.items.BOWL_OF_QUADAV_STEW
    else
        return 0
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
end

return entity
