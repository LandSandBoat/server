-----------------------------------
-- Area: Maze of Shakhrami
--   NM: Wyrmfly
-- Involved in Eco Warrior (Windurst)
-----------------------------------
local ID = require("scripts/zones/Maze_of_Shakhrami/IDs")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.POISON)
end

entity.onMobDeath = function(mob, player, optParams)
    if
        player:getCharVar("EcoStatus") == 201 and
        player:hasStatusEffect(xi.effect.LEVEL_RESTRICTION)
    then
        local allFliesDead = true
        for i = ID.mob.WYRMFLY_OFFSET, ID.mob.WYRMFLY_OFFSET + 2 do
            if i ~= mob:getID() and GetMobByID(i):isAlive() then
                allFliesDead = false
            end
        end

        if allFliesDead then
            player:setCharVar("EcoStatus", 202)
        end
    end
end

return entity
