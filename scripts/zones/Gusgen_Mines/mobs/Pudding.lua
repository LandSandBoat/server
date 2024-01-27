-----------------------------------
-- Area: Maze of Shakhrami
--   NM: Pudding
-- Involved in Eco Warrior (Bastok)
-----------------------------------
local ID = zones[xi.zone.GUSGEN_MINES]
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.SLOW)
end

entity.onMobDeath = function(mob, player, optParams)
    if
        player:getCharVar('EcoStatus') == 101 and
        player:hasStatusEffect(xi.effect.LEVEL_RESTRICTION)
    then
        local bothDead = true
        for i = ID.mob.PUDDING_OFFSET, ID.mob.PUDDING_OFFSET + 1 do
            if i ~= mob:getID() and GetMobByID(i):isAlive() then
                bothDead = false
            end
        end

        if bothDead then
            player:setCharVar('EcoStatus', 102)
        end
    end
end

return entity
