-----------------------------------
-- Area: Beadeaux (254)
--  Mob: Zircon Quadav
-- Notes: PH for Zo'Khu Blackcloud
--  Bowl of Quadav Stew is a guaranteed steal with
--  Quest THE_TENSHODO_SHOWDOWN active
-----------------------------------
local ID = zones[xi.zone.BEADEAUX]
-----------------------------------
local entity = {}

local zoKhuPHTable =
{
    [ID.mob.ZO_KHU_BLACKCLOUD - 2] = ID.mob.ZO_KHU_BLACKCLOUD, -- -294.223 -3.504 -206.657
}

entity.onSteal = function(player, target, ability, action)
    if
        player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.THE_TENSHODO_SHOWDOWN) == xi.questStatus.QUEST_ACCEPTED and
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
    xi.mob.phOnDespawn(mob, zoKhuPHTable, 10, 3600) -- 1 to 5 hours
end

return entity
