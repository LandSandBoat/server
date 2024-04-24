-----------------------------------
--  Boreas Mantle
--
--  Description: Used by Phantom Puk (Shadows of the Mind ISNM)
--    Spawns Phantom Puk clones
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local phantomPuk = mob:getID()
    local hateTarget = GetMobByID(phantomPuk):getTarget()
    local phantomHPP = math.floor((mob:getHP() / mob:getMaxHP()) * 100)

    -- Update enmity for clones
    for cloneId = phantomPuk + 1, phantomPuk + 4 do
        local clone = GetMobByID(cloneId)

        if
            clone and
            not clone:isSpawned()
        then
            clone:setSpawn(mob:getXPos() + math.random(1, 2), mob:getYPos(), mob:getZPos() + math.random(1, 2))
            SpawnMob(cloneId):updateEnmity(hateTarget)
            local cloneHP = math.floor(clone:getMaxHP() * phantomHPP) / 100
            clone:setMod(xi.mod.DMG, 20000) -- Clones take triple damage
            clone:setHP(cloneHP)
        end
    end

    -- Handle Despawn of clones every 30 seconds
    mob:timer(30000, function(mobArg)
        local mobArgId = mobArg:getID()

        for clone = mobArgId + 1, mobArgId + 4 do
            DespawnMob(clone)
        end
    end)
end

return mobskillObject
