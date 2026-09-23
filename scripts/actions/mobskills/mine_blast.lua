-----------------------------------
-- Mine Blast
-- Family: Mines (Qiqirn Mine / Goblin Mine)
-- Description: AOE: Varies. 16' for Goblin Bombs in [S].
-- TODO: Behavior of mines varies, we may eventually want to split up to multiple files once captures are made.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getMainLvl() + 2
    params.fTP            = { 100, 100, 100 } -- TODO: Capture fTPs. (Varies by mob)
    params.element        = xi.element.FIRE
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.FIRE
    params.shadowBehavior = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

    -- TODO: Cheese Hoarder Gigiroon Mines

    -- TODO: Qiqirn Mines

    -- TODO: Goblin mines in [S] zones

    -- TODO: Blifnix Oilycheek's Goblin Mines

    -- Assault: Excavation Duty
    if mob:getZoneID() == xi.zone.LEBROS_CAVERN then
        mob:entityAnimationPacket('bom0') -- Assault: Excavation Duty

        local targetId    = target:getID()
        local firstRockId = zones[xi.zone.LEBROS_CAVERN].mob.BRITTLE_ROCK
        local info        =
        {
            damage     = 170,
            hitsLanded = 1,
            attackType = xi.attackType.MAGICAL,
            damageType = xi.damageType.FIRE,
        }

        if
            targetId >= firstRockId and
            targetId <= firstRockId + 9
        then
            target:timer(2000, function(rockArg)
                rockArg:setHP(0)
            end)

            info.damage = 8
        end

        -- Mobs take 170 in uncapped
        -- TODO: Capture mine damage to mobs in 70/60/50 cap
        if xi.mobskills.processDamage(mob, target, skill, action, info) then
            target:takeDamage(info.damage, mob, info.attackType, info.damageType)
        end

        return info.damage
    end

    -- Default
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

mobskillObject.onMobSkillFinalize = function(mob, skill)
    if mob:getZoneID() == xi.zone.LEBROS_CAVERN then
        mob:timer(4000, function(bombArg)
            if bombArg and bombArg:isAlive() then
                DespawnMob(bombArg:getTargID(), bombArg:getInstance())
            end
        end)

    else
        mob:entityAnimationPacket('mai1') -- Animation: Mine jumps up and explodes.
        mob:setHP(0) -- TODO: Mine appears to despawn after 4-5 seconds, not have HP set to 0.
    end
end

return mobskillObject
