-----------------------------------
-- Area: The Shrine of Ru'Avitau
--   NM: Kirin
-----------------------------------
local ID = zones[xi.zone.THE_SHRINE_OF_RUAVITAU]
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

-- God mob IDs (offset from Kirin)
local gods = { ID.mob.KIRIN + 1, ID.mob.KIRIN + 2, ID.mob.KIRIN + 3, ID.mob.KIRIN + 4 }

local callPetParams =
{
    dieWithOwner = true,
    superLink = true,
    inactiveTime = 9000, -- 9 second cast time
    maxSpawns = 1,
}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 5, 'Kirins_Avatar')
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.TERROR)
    mob:setMobMod(xi.mobMod.ASTRAL_PET_OFFSET, 5)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    mob:setMod(xi.mod.DEFP, 30)
    mob:setMod(xi.mod.REGEN, 50)
    mob:setMod(xi.mod.REGAIN, 1000) -- Kirin never stops using TP moves unless casting
end

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.mobSkill.ASTRAL_FLOW_1, hpp = math.randomInt(40, 65) },
        },
    })

    mob:setBaseSpeed(75)
    mob:setMod(xi.mod.STUN_RES_RANK, 11)
    mob:setLocalVar('godSpawnTime', GetSystemTime() + math.randomInt(180, 300)) -- 3-5 minutes

    -- Add slight delay to allow Kirin to load in before the message is sent
    mob:timer(300, function(mobArg)
        if mobArg then
            mobArg:messageText(mobArg, ID.text.KIRIN_OFFSET)
        end
    end)

    -- Wait 5 seconds after spawn to cast
    mob:setMagicCastingEnabled(false)
    mob:timer(5000, function(mobArg)
        if mobArg then
            mobArg:setMagicCastingEnabled(true)
        end
    end)
end

entity.onMobFight = function(mob, target)
    -- Check if it's time to spawn a god
    local numAdds = mob:getLocalVar('numAdds')
    if GetSystemTime() >= mob:getLocalVar('godSpawnTime') and numAdds < 4 then
        -- Find which gods have never been spawned
        local availableGods = {}
        for i = 1, 4 do
            if mob:getLocalVar('add' .. i) == 0 then
                table.insert(availableGods, gods[i])
            end
        end

        -- Spawn one random god if any are available
        if #availableGods > 0 then
            local selectedGod = availableGods[math.randomInt(1, #availableGods)]

            -- Use callPets to spawn exactly one god
            if xi.mob.callPets(mob, selectedGod, callPetParams) then
                -- Mark this god as spawned and update counter
                for i = 1, 4 do
                    if gods[i] == selectedGod then
                        mob:setLocalVar('add' .. i, 1)
                        break
                    end
                end

                mob:setLocalVar('numAdds', numAdds + 1)

                -- Set next god spawn time (3-5 minutes later)
                mob:setLocalVar('godSpawnTime', GetSystemTime() + math.randomInt(180, 300))
            end
        end
    end
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    -- Kirin uses a set of skills 2 times in a row, 3 times if below 50% HP
    if mob:getLocalVar('skillRepeat') == 0 then
        local skillSets =
        {
            { xi.mobSkill.HEAT_BREATH_1 },
            { xi.mobSkill.DEADLY_HOLD_1 },
            { xi.mobSkill.GREAT_SANDSTORM_1, xi.mobSkill.GREAT_WHIRLWIND_1 },
            { xi.mobSkill.TAIL_SWING_1,      xi.mobSkill.TAIL_SMASH_1      },
        }

        -- Choose which skill set to use next
        local combo = skillSets[math.randomInt(1, #skillSets)]

        -- Choose which skill to use from the set
        mob:setLocalVar('nextSkill', combo[math.randomInt(1, #combo)])

        if mob:getHPP() < 50 then
            mob:setLocalVar('skillRepeat', 3)
        else
            mob:setLocalVar('skillRepeat', 2)
        end
    end

    return mob:getLocalVar('nextSkill')
end

entity.onMobWeaponSkill = function(mob, target, skill, action)
    local skillId = skill:getID()

    -- Skills outside the sets (Astral Flow) do not advance the block
    if skillId ~= mob:getLocalVar('nextSkill') then
        return
    end

    -- Only fire once per use
    if target:getID() ~= action:getPrimaryTargetID() then
        return
    end

    local pairedSkill =
    {
        [xi.mobSkill.GREAT_SANDSTORM_1] = xi.mobSkill.GREAT_WHIRLWIND_1,
        [xi.mobSkill.GREAT_WHIRLWIND_1] = xi.mobSkill.GREAT_SANDSTORM_1,
        [xi.mobSkill.TAIL_SWING_1     ] = xi.mobSkill.TAIL_SMASH_1,
        [xi.mobSkill.TAIL_SMASH_1     ] = xi.mobSkill.TAIL_SWING_1,
    }

    -- If the skill has a paired skill, choose randomly between the two
    local nextSkill = pairedSkill[skillId]
    if nextSkill and math.randomInt(1, 2) <= 1 then
        mob:setLocalVar('nextSkill', nextSkill)
    end

    mob:setLocalVar('skillRepeat', math.max(mob:getLocalVar('skillRepeat') - 1, 0))
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [1] = { xi.magic.spell.STONEGA_IV, target, false, xi.action.type.DAMAGE_TARGET,     nil,               0, 100 },
        [2] = { xi.magic.spell.STONE_V,    target, false, xi.action.type.DAMAGE_TARGET,     nil,               0, 100 },
        [3] = { xi.magic.spell.QUAKE,      target, false, xi.action.type.DAMAGE_TARGET,     nil,               0, 100 },
        [4] = { xi.magic.spell.RASP,       target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.RASP,    0, 100 },
        [5] = { xi.magic.spell.SLEEPGA,    target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.SLEEP_I, 1, 100 },
    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

entity.onMobDeath = function(mob, player, optParams)
    if player then
        player:addTitle(xi.title.KIRIN_CAPTIVATOR)
        player:showText(mob, ID.text.KIRIN_OFFSET + 1)
    end
end

return entity
