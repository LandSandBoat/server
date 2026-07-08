---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.SILENCE)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar('leveretsSpawned', 0)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 15)
    mob:setMod(xi.mod.DESPAWN_TIME_REDUCTION, 15)
end

entity.onMobFight = function(mob, target)
    -- At 85% HP, spawn the Bearclaw Leverets and choose one to be the "real" one
    if
        mob:getHPP() <= 85 and
        mob:getLocalVar('leveretsSpawned') == 0
    then
        mob:setLocalVar('leveretsSpawned', 1)
        local battlefield = mob:getBattlefield()

        if not battlefield then
            return
        end

        local baseId = mob:getID()

        battlefield:setLocalVar('baseId', baseId)

        SpawnMob(baseId + 1) -- Bearclaw Leveret
        SpawnMob(baseId + 2) -- Bearclaw Leveret
        SpawnMob(baseId + 3) -- Bearclaw Leveret
        SpawnMob(baseId + 4) -- Bearclaw Leveret
        SpawnMob(baseId + 5) -- Bearclaw Leveret

        for i = 1, 5 do
            GetMobByID(baseId + i):updateEnmity(target)
        end

        local chosenLeveret = GetMobByID(baseId + math.randomInt(1, 5))
        if chosenLeveret then
            chosenLeveret:setLocalVar('chosenLeveret', 1)
            chosenLeveret:setMobMod(xi.mobMod.ADD_EFFECT, 1)
        end
    end
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    local skills =
    {
        xi.mobSkill.FOOT_KICK_1,
        xi.mobSkill.WHIRL_CLAWS_1,
        xi.mobSkill.SNOW_CLOUD_1,
        xi.mobSkill.WILD_GINSENG,
    }

    return skills[math.randomInt(1, #skills)]
end

return entity
