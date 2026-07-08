-----------------------------------
-- Area: Maze of Shakhrami
--   NM: Pudding
-- Involved in Eco Warrior (Bastok)
-----------------------------------
local ID = zones[xi.zone.GUSGEN_MINES]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180) -- 3 minutes
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.SLOW)
end

entity.onMobDeath = function(mob, player, optParams)
    local pudding = ID.mob.PUDDING_OFFSET

    if
        player:getCharVar('EcoStatus') == 101 and
        player:hasStatusEffect(xi.effect.LEVEL_RESTRICTION)
    then
        local bothDead = true
        for i = pudding, pudding + 1 do
            local nmCheck = GetMobByID(i)

            if
                i ~= mob:getID() and
                nmCheck and
                nmCheck:isAlive()
            then
                bothDead = false
            end
        end

        if bothDead then
            player:setCharVar('EcoStatus', 102)
        end
    end
end

return entity
