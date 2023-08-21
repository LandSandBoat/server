-----------------------------------
-- Area: Beadeaux (254)
--  Mob: Bronze Quadav
-- Notes: Bowl of Quadav Stew is a guaranteed steal with
--  Quest THE_TENSHODO_SHOWDOWN active
-----------------------------------
local entity = {}

entity.onSteal = function(player, target, ability, action)
    if
        player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_TENSHODO_SHOWDOWN) == QUEST_ACCEPTED and
        not player:hasItem(xi.item.BOWL_OF_QUADAV_STEW)
    then
        return xi.item.BOWL_OF_QUADAV_STEW
    else
        return 0
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
end

return entity
