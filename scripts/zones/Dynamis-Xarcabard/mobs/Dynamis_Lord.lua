-----------------------------------
-- Area: Dynamis - Xarcabard
-- NM: Dynamis Lord
-- Note: Mega Boss
-- Spawned by trading a Shrouded Bijou to the ??? in front of Castle Zvahl.
-----------------------------------
local ID = zones[xi.zone.DYNAMIS_XARCABARD]
-----------------------------------
---@type TMobEntity
local entity = {}

local specialTable =
{
    [1] = { skill = xi.mobSkill.MIGHTY_STRIKES_1, threshold = 90, dialogueOffset =  9 },
    [2] = { skill = xi.mobSkill.BLOOD_WEAPON_1,   threshold = 70, dialogueOffset = 10 },
    [3] = { skill = xi.mobSkill.HUNDRED_FISTS_1,  threshold = 50, dialogueOffset = 11 },
    [4] = { skill = xi.mobSkill.CHAINSPELL_1,     threshold = 30, dialogueOffset = 12 },
}

local function beginSummon(mob)
    mob:setLocalVar('isBusy', 1)
    mob:setBaseSpeed(0)
    xi.combat.behavior.disableAllActions(mob)
    mob:entityAnimationPacket('casm')
end

local function endSummon(mob)
    mob:setLocalVar('isBusy', 0)
    mob:setBaseSpeed(60)
    xi.combat.behavior.enableAllActions(mob)
    mob:entityAnimationPacket('shsm')
end

local function pickCloneSkill(mob)
    local cloneSkills = {}
    local currentHP   = mob:getHPP()

    if currentHP >= 50 then
        table.insert(cloneSkills, xi.mobSkill.VIOLENT_RUPTURE)
        table.insert(cloneSkills, xi.mobSkill.OBLIVION_SMASH_1)
        table.insert(cloneSkills, xi.mobSkill.TERA_SLASH_1)
    else
        table.insert(cloneSkills, xi.mobSkill.DYNAMIC_IMPLOSION)
        table.insert(cloneSkills, xi.mobSkill.OBLIVION_SMASH_2)
        table.insert(cloneSkills, xi.mobSkill.TERA_SLASH_2)
    end

    return cloneSkills[math.randomInt(1, #cloneSkills)]
end

local summonClones = function(mob)
    mob:messageText(mob, ID.text.DYNAMIS_LORD_DIALOGUE + 14)
    beginSummon(mob)

    mob:timer(3000, function(mobArg)
        if not mobArg:isAlive() then
            return
        end

        endSummon(mobArg)

        local director = GetNPCByID(ID.npc.DYNAMIS_LORD_DIRECTOR)
        if not director then
            return
        end

        -- Generate a list of possible targets in range.
        local targets = {}
        for _, entry in ipairs(mobArg:getEnmityList()) do
            local member = entry.entity

            if
                member and
                member:isPC() and
                member:isAlive() and
                mobArg:checkDistance(member) <= 50
            then
                table.insert(targets, member)
            end
        end

        -- If no targets were found, use the current target as a fallback.
        if #targets == 0 then
            local currentTarget = mobArg:getTarget()

            if currentTarget and currentTarget:isAlive() then
                table.insert(targets, currentTarget)
            end
        end

        -- Something went wrong, can't find any targets - return.
        if #targets == 0 then
            return
        end

        -- Generate a list of possible clones to spawn.
        local cloneMobs = {}
        for cloneId = ID.mob.DYNAMIS_LORD, ID.mob.DYNAMIS_LORD + 5 do
            local clone = GetMobByID(cloneId)
            if not clone then
                return
            end

            if not clone:isSpawned() then
                table.insert(cloneMobs, clone)
            end
        end

        cloneMobs        = utils.shuffle(cloneMobs)
        local cloneCount = math.min(3, #cloneMobs)

        if cloneCount == 0 then
            return
        end

        -- Pick a random clone to be the real one, and store its ID on the director.
        local realClone = math.randomInt(1, cloneCount)
        director:setLocalVar('[Lord]RealId', cloneMobs[realClone]:getID())

        -- All clones use the same skill.
        local cloneSkill = pickCloneSkill(mobArg)

        -- Spawn the clones near their targets, and have them use a skill on their target.
        for cloneIndex = 1, cloneCount do
            local clone       = cloneMobs[cloneIndex]
            local cloneTarget = utils.randomEntry(targets)
            local spawnPos    = utils.getNearPosition(cloneTarget:getPos(), math.randomInt(2, 4), math.randomFloat(0, 1) * 2 * math.pi)

            clone:setSpawn(spawnPos.x, spawnPos.y, spawnPos.z)
            clone:spawn()
            clone:setHP(mobArg:getHP())
            clone:setMagicCastingEnabled(false)

            if cloneIndex ~= realClone then
                clone:setUnkillable(true)
            end

            clone:updateEnmity(cloneTarget)

            -- Schedule timers. 1.5s for the skill, 6s for fake clones to despawn, 8s for the real clone to be able to cast again.
            clone:timer(1500, function(cloneArg)
                if
                    cloneArg:isAlive() and
                    cloneTarget:isAlive()
                then
                    cloneArg:useMobAbility(cloneSkill, cloneTarget)
                end
            end)

            if cloneIndex == realClone then
                clone:timer(8000, function(cloneArg)
                    cloneArg:setMagicCastingEnabled(true)
                end)
            else
                clone:timer(6000, function(cloneArg)
                    cloneArg:setUnkillable(false)
                    xi.combat.behavior.enableAllActions(cloneArg)

                    if cloneArg:isAlive() then
                        DespawnMob(cloneArg:getID())
                    end
                end)
            end
        end

        DespawnMob(mobArg:getID())
    end)
end

local summonYinYang = function(mob)
    mob:messageText(mob, ID.text.DYNAMIS_LORD_DIALOGUE + 7)
    beginSummon(mob)

    mob:timer(3000, function(mobArg)
        if not mobArg:isAlive() then
            return
        end

        endSummon(mobArg)

        local currentTarget  = mobArg:getTarget()
        local spawnLocations =
        {
            [ID.mob.YING] = { x = -404.311,  y = -44, z = 38.5846, rot =  67 },
            [ID.mob.YANG] = { x = -406.0623, y = -44, z =  2.6398, rot = 191 },
        }

        for dragonId, spawnPos in pairs(spawnLocations) do
            local dragon = GetMobByID(dragonId)
            if not dragon then
                return
            end

            if not dragon:isSpawned() then
                dragon:setSpawn(spawnPos.x, spawnPos.y, spawnPos.z, spawnPos.rot)
                dragon:setSpawnAnimation(xi.spawnAnimation.SPECIAL)
                dragon:spawn()

                if currentTarget then
                    dragon:updateEnmity(currentTarget)
                end
            end
        end
    end)
end

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.BLIND)
    mob:addImmunity(xi.immunity.POISON)
    mob:addImmunity(xi.immunity.ELEGY)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
end

entity.onMobSpawn = function(mob)
    mob:resetLocalVars()
    mob:setBaseSpeed(60)
    mob:setUnkillable(false)
    xi.combat.behavior.enableAllActions(mob)

    mob:setDamage(145, xi.slot.MAIN)
    mob:setMod(xi.mod.ATT, 517)
    mob:setMod(xi.mod.DEF, 364)
    mob:setMod(xi.mod.EVA, 301)
    mob:setMod(xi.mod.UFASTCAST, 100)
    mob:setMod(xi.mod.REGAIN, 50)

    mob:setMobMod(xi.mobMod.MAGIC_COOL, 27)

    local director = GetNPCByID(ID.npc.DYNAMIS_LORD_DIRECTOR)
    if not director then
        return
    end

    if director:getLocalVar('[Lord]RealId') == 0 then
        director:setLocalVar('[Lord]RealId', mob:getID())
    end
end

entity.onMobEngage = function(mob, target)
    local director = GetNPCByID(ID.npc.DYNAMIS_LORD_DIRECTOR)
    if not director then
        return
    end

    -- Only run this logic for the real Dynamis Lord.
    if director:getLocalVar('[Lord]RealId') ~= mob:getID() then
        return
    end

    -- Gates engage logic from running again once Dynamis Lord has been popped.
    if director:getLocalVar('[2hour]Index') ~= 0 then
        return
    end

    local yinYangTime = GetSystemTime() + math.randomInt(60, 75)

    director:setLocalVar('[2hour]Index', 1)
    director:setLocalVar('[2hour]Time', 0)
    director:setLocalVar('[Timer]YingYang', yinYangTime)
    director:setLocalVar('[Timer]Clones', yinYangTime + math.randomInt(45, 60))
end

entity.onMobFight = function(mob, target)
    -- Only run this logic for the real Dynamis Lord.
    local director = GetNPCByID(ID.npc.DYNAMIS_LORD_DIRECTOR)
    if not director then
        return
    end

    if director:getLocalVar('[Lord]RealId') ~= mob:getID() then
        return
    end

    if xi.combat.behavior.isEntityBusy(mob) then
        return
    end

    local ying = GetMobByID(ID.mob.YING)
    if not ying then
        return
    end

    local yang = GetMobByID(ID.mob.YANG)
    if not yang then
        return
    end

    -- Check to see if it's time to summon Yin and Yang.
    local currentTime = GetSystemTime()
    if
        currentTime >= director:getLocalVar('[Timer]YingYang') and
        not ying:isSpawned() and
        not yang:isSpawned()
    then
        summonYinYang(mob)
        return
    end

    -- Check to see if it's time to summon clones.
    if currentTime >= director:getLocalVar('[Timer]Clones') then
        director:setLocalVar('[Timer]Clones', currentTime + math.randomInt(105, 120))
        summonClones(mob)
        return
    end

    -- Can't use additional special abilities if one is active.
    if
        mob:hasStatusEffect(xi.effect.MIGHTY_STRIKES) or
        mob:hasStatusEffect(xi.effect.BLOOD_WEAPON) or
        mob:hasStatusEffect(xi.effect.HUNDRED_FISTS) or
        mob:hasStatusEffect(xi.effect.CHAINSPELL)
    then
        return
    end

    -- Run 2-hour cycle.
    local specialIndex = director:getLocalVar('[2hour]Index')
    if specialIndex <= #specialTable then
        local special = specialTable[specialIndex]

        if mob:getHPP() <= special.threshold then
            director:setLocalVar('[2hour]Index', specialIndex + 1)

            if specialIndex == #specialTable then
                director:setLocalVar('[2hour]Time', currentTime + 150)
            end

            mob:messageText(mob, ID.text.DYNAMIS_LORD_DIALOGUE + special.dialogueOffset)
            mob:useMobAbility(special.skill)
        end

        return
    end

    -- If we have cycled through all 4 HPP based special abilities, use a random one every 2:30.
    local nextSpecialTime = director:getLocalVar('[2hour]Time')
    if
        nextSpecialTime > 0 and
        currentTime >= nextSpecialTime
    then
        director:setLocalVar('[2hour]Time', currentTime + 150)
        mob:messageText(mob, ID.text.DYNAMIS_LORD_DIALOGUE + 13) -- Quail before my might. Fear my terrible power...
        mob:useMobAbility(specialTable[math.randomInt(1, #specialTable)].skill)
    end
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    local skillList =
    {
        xi.mobSkill.TRANSFUSION,
        xi.mobSkill.MANA_STORM,
    }

    if mob:getHPP() >= 50 then
        table.insert(skillList, xi.mobSkill.VIOLENT_RUPTURE)
        table.insert(skillList, xi.mobSkill.DYNAMIC_ASSAULT)
        table.insert(skillList, xi.mobSkill.OBLIVION_SMASH_1)
        table.insert(skillList, xi.mobSkill.TERA_SLASH_1)
    else
        table.insert(skillList, xi.mobSkill.DYNAMIC_IMPLOSION)
        table.insert(skillList, xi.mobSkill.OBLIVION_SMASH_2)
        table.insert(skillList, xi.mobSkill.TERA_SLASH_2)
    end

    return skillList[math.randomInt(1, #skillList)]
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        xi.magic.spell.FIRAGA_III,
        xi.magic.spell.BLIZZAGA_III,
        xi.magic.spell.AEROGA_III,
        xi.magic.spell.STONEGA_III,
        xi.magic.spell.THUNDAGA_III,
        xi.magic.spell.WATERGA_III,
        xi.magic.spell.PARALYGA,
        xi.magic.spell.SILENCEGA,
        xi.magic.spell.DISPELGA,
        xi.magic.spell.BINDGA,
        xi.magic.spell.SLEEPGA,
        xi.magic.spell.SLOWGA,
    }

    if mob:getHPP() <= 10 then
        table.insert(spellList, xi.magic.spell.DEATH)
    end

    return spellList[math.randomInt(1, #spellList)]
end

entity.onMobDisengage = function(mob)
    local director = GetNPCByID(ID.npc.DYNAMIS_LORD_DIRECTOR)
    if not director then
        return
    end

    local realDynamisLord = director:getLocalVar('[Lord]RealId')
    if not realDynamisLord then
        return
    end

    if realDynamisLord ~= mob:getID() then
        return
    end

    xi.combat.behavior.enableAllActions(mob)
    mob:setLocalVar('isBusy', 0)
    director:setLocalVar('[2hour]Index', 0)
    director:setLocalVar('[2hour]Time', 0)
    director:setLocalVar('[Timer]YingYang', 0)
    director:setLocalVar('[Timer]Clones', 0)
    mob:messageText(mob, ID.text.DYNAMIS_LORD_DIALOGUE + 6)
end

entity.onMobDeath = function(mob, player, optParams)
    if player then
        player:addTitle(xi.title.LIFTER_OF_SHADOWS)
        xi.dynamis.megaBossOnDeath(mob, player, optParams)
    end

    if optParams.isKiller or optParams.noKiller then
        local director = GetNPCByID(ID.npc.DYNAMIS_LORD_DIRECTOR)
        if not director then
            return
        end

        if director:getLocalVar('[Lord]RealId') ~= mob:getID() then
            return
        end

        mob:messageText(mob, ID.text.DYNAMIS_LORD_DIALOGUE + 2)
        DespawnMob(ID.mob.YING)
        DespawnMob(ID.mob.YANG)

        director:setLocalVar('[2hour]Index', 0)
        director:setLocalVar('[2hour]Time', 0)
        director:setLocalVar('[Timer]YingYang', 0)
        director:setLocalVar('[Timer]Clones', 0)
    end
end

return entity
