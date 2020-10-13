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

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.POISON)
end

function onMobDeath(mob, player, isKiller)
    if player:getCharVar("EcoStatus") == 201 and player:hasStatusEffect(tpz.effect.LEVEL_RESTRICTION) then
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