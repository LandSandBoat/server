-----------------------------------
-- PET: Avatar
-- TODO: More accurate Light Spirit logic. (Curaga Chance? Seems random.)
-- TODO: Accurate HP/MP/Stat scaling for Spirits.
-- TODO: There are some claims that position/facing of the Light Spirit can influence its behavior. Find out if it's real?
-----------------------------------
require('scripts/globals/summon')
require('scripts/utils/utils')
-----------------------------------

xi = xi or {}
xi.pets = xi.pets or {}
xi.pets.avatar = xi.pets.avatar or {}

xi.pets.avatar.lightSpiritSpells =
{
    buffs =
    {
        { spell = xi.magic.spell.PROTECT_V,   effect = xi.effect.PROTECT, tier = 5, level = 76 },
        { spell = xi.magic.spell.PROTECT_IV,  effect = xi.effect.PROTECT, tier = 4, level = 68 },
        { spell = xi.magic.spell.PROTECT_III, effect = xi.effect.PROTECT, tier = 3, level = 47 },
        { spell = xi.magic.spell.PROTECT_II,  effect = xi.effect.PROTECT, tier = 2, level = 27 },
        { spell = xi.magic.spell.PROTECT,     effect = xi.effect.PROTECT, tier = 1, level =  7 },
        { spell = xi.magic.spell.SHELL_V,     effect = xi.effect.SHELL,   tier = 5, level = 76 },
        { spell = xi.magic.spell.SHELL_IV,    effect = xi.effect.SHELL,   tier = 4, level = 68 },
        { spell = xi.magic.spell.SHELL_III,   effect = xi.effect.SHELL,   tier = 3, level = 57 },
        { spell = xi.magic.spell.SHELL_II,    effect = xi.effect.SHELL,   tier = 2, level = 37 },
        { spell = xi.magic.spell.SHELL,       effect = xi.effect.SHELL,   tier = 1, level = 10 },
        { spell = xi.magic.spell.HASTE,       effect = xi.effect.HASTE,             level = 48 },
        { spell = xi.magic.spell.REGEN,       effect = xi.effect.REGEN,             level = 21 },
    },

    cures =
    {
        { spell = xi.magic.spell.CURE_VI,                                           level = 80 },
        { spell = xi.magic.spell.CURE_V,                                            level = 61 },
        { spell = xi.magic.spell.CURE_IV,                                           level = 41 },
        { spell = xi.magic.spell.CURE_III,                                          level = 21 },
        { spell = xi.magic.spell.CURE_II,                                           level = 11 },
        { spell = xi.magic.spell.CURE,                                              level =  1 },
    },

    curagas =
    {
        { spell = xi.magic.spell.CURAGA_V,                                          level = 91 },
        { spell = xi.magic.spell.CURAGA_IV,                                         level = 71 },
        { spell = xi.magic.spell.CURAGA_III,                                        level = 51 },
        { spell = xi.magic.spell.CURAGA_II,                                         level = 31 },
        { spell = xi.magic.spell.CURAGA,                                            level = 16 },
    },
}

local function tryCureSpell(pet)
    local master = pet:getMaster()
    if not master then
        return
    end

    local cureTarget               = nil
    local lowestHitPointPercentage = 100

    for _, member in pairs(master:getAlliance()) do
        if
            member and
            member:isAlive() and
            pet:checkDistance(member) < 20
        then
            local memberHitPointPercentage = member:getHPP()

            if
                memberHitPointPercentage <= 75 and
                memberHitPointPercentage < lowestHitPointPercentage
            then
                lowestHitPointPercentage = memberHitPointPercentage
                cureTarget = member
            end
        end
    end

    if not cureTarget then
        return
    end

    local petLevel   = pet:getMainLvl()
    local spellGroup = xi.pets.avatar.lightSpiritSpells.cures

    if
        petLevel >= 16 and
        -- TODO: Check this. Guessed.
        math.random(1, 100) <= math.min(10 + xi.summon.getSummoningSkillOverCap(pet), 50)
    then
        spellGroup = xi.pets.avatar.lightSpiritSpells.curagas
    end

    for _, spellData in ipairs(spellGroup) do
        if petLevel >= spellData.level then
            return spellData.spell, cureTarget
        end
    end

    return nil, nil
end

local function tryBuffSpell(pet)
    local master = pet:getMaster()
    if not master then
        return
    end

    local petLevel     = pet:getMainLvl()
    local partyMembers = utils.shuffle(master:getParty())

    for _, spellData in ipairs(xi.pets.avatar.lightSpiritSpells.buffs) do
        if petLevel >= spellData.level then
            for _, member in ipairs(partyMembers) do
                if
                    member and
                    member:isAlive() and
                    pet:checkDistance(member) < 20
                then
                    local statusEffect = member:getStatusEffect(spellData.effect)
                    local canApplyBuff = not statusEffect or spellData.tier and statusEffect:getTier() < spellData.tier

                    if canApplyBuff then
                        return spellData.spell, member
                    end
                end
            end
        end
    end

    return nil, nil
end

local function getMagicCastCooldown(pet)
    -- 45 Seconds is the neutral spell cooldown if you are at your natural summoning skill cap.
    local castingCooldown = 45

    local master = pet:getMaster()

    if not master then
        return 0
    end

    -- You are penalized if your summoning skill is below your max skill for your level, increasing spell cooldown by 1 second for every 3 skill under, up to a maximum of 90s.
    -- You are rewarded if your summoning skill is above your max skill for your level, reducing spell cooldown by 1 second for every 3 skill over, down to a minimum of 30s.
    local summoningSkill  = master:getSkillLevel(xi.skill.SUMMONING_MAGIC)
    local maxSkill        = master:getMaxSkillLevel(pet:getMainLvl(), xi.job.SMN, xi.skill.SUMMONING_MAGIC)
    local skillDifference = summoningSkill - maxSkill

    if skillDifference >= 0 then
        castingCooldown = castingCooldown - math.floor(skillDifference / 3)
    else
        castingCooldown = castingCooldown + math.floor(math.abs(skillDifference) / 3)
    end

    castingCooldown = math.min(math.max(castingCooldown, 30), 90)

    -- Astral Flow sets the spell cooldown to 30 seconds, regardless of skill.
    if master:hasStatusEffect(xi.effect.ASTRAL_FLOW) then
        castingCooldown = 30
    end

    -- Weather & Spirit Cast Reductions
    castingCooldown = castingCooldown - master:getMod(xi.mod.SPIRIT_CAST_REDUCTION)

    local petElement = master:getPetElement()

    -- AFAIK unaffected by scholar storms on the player, so we use weather of the pet
    local actorWeather = pet:getWeather()
    -- Strong weathers.
    if
        actorWeather == xi.data.element.getAssociatedSingleWeather(petElement) or
        actorWeather == xi.data.element.getAssociatedDoubleWeather(petElement)
    then
        castingCooldown = castingCooldown - 2
    -- Weak weathers.
    elseif
        actorWeather == xi.data.element.getOppositeSingleWeather(petElement) or
        actorWeather == xi.data.element.getOppositeDoubleWeather(petElement)
    then
        castingCooldown = castingCooldown + 2
    end

    local dayElement = VanadielDayElement()
    -- Strong day.
    if dayElement == petElement then
        castingCooldown = castingCooldown - 3
    -- Weak day.
    elseif dayElement == xi.data.element.getElementWeakness(petElement) then
        castingCooldown = castingCooldown + 3
    end

    return math.max(castingCooldown, 1)
end

-- Sets the SMN pet's base damage.
-- Used as a hook for 75 era modules.
---@param pet CBaseEntity
xi.pets.avatar.calculateAvatarWeaponDamage = function(pet)
    local weaponDamage = pet:getMainLvl() + 2 -- TODO: Verify retail base damage.

    pet:setDamage(weaponDamage, xi.slot.MAIN)
    pet:setDamage(weaponDamage, xi.slot.RANGED)
end

xi.pets.avatar.onMobSpawn = function(pet)
    local master = pet:getMaster()
    if not master then
        return
    end

    if master:getObjType() ~= xi.objType.PC then
        return
    end

    -- Set up avatar's base damage.
    xi.pets.avatar.calculateAvatarWeaponDamage(pet)

    local petType       = pet:getPetID()

    -- Only Spirits cast Magic.
    if
        petType >= xi.petId.FIRE_SPIRIT and
        petType <= xi.petId.DARK_SPIRIT
    then
        local spellCooldown = getMagicCastCooldown(pet)
        -- Freshly summoned spirits may not cast until their spell cooldown is up.
        pet:setMobMod(xi.mobMod.MAGIC_DELAY, 0)
        pet:setMagicCastingEnabled(false)

        pet:timer(spellCooldown * 1000, function(petArg)
            petArg:setMagicCastingEnabled(true)
        end)

        -- TODO: Get accurate HP/MP values for spirits. This is wrong, but without it Elementals would have extremely low MP amounts.
        pet:setMod(xi.mod.MPP, 300)
        pet:updateHealth()
        pet:setMP(pet:getMaxMP())

        pet:setMobMod(xi.mobMod.MAGIC_COOL, spellCooldown)
    end
end

-- Assault from Idle will trigger onMobEngage.
xi.pets.avatar.onMobEngage = function(pet)
    if pet:getPetID() == xi.petId.LIGHT_SPIRIT then
        local spellCooldown = getMagicCastCooldown(pet)

        pet:setMobMod(xi.mobMod.MAGIC_COOL, spellCooldown)
    end
end

xi.pets.avatar.onMobSpellChoose = function(pet)
    local master = pet:getMaster()
    if
        not master or
        master:getObjType() ~= xi.objType.PC
    then
        return
    end

    -- No override for spirits that are not Light Spirit.
    if pet:getPetID() ~= xi.petId.LIGHT_SPIRIT then
        return nil, nil
    end

    local spellCooldown = getMagicCastCooldown(pet)

    -- Update spell cooldown.
    if pet:isEngaged() then
        pet:setMobMod(xi.mobMod.MAGIC_COOL, spellCooldown)
    else
        pet:setMobMod(xi.mobMod.MAGIC_COOL, math.max(math.floor(spellCooldown / 2), 1))
    end

    -- Check for wounded allies first.
    local spellToCast, spellTarget = tryCureSpell(pet)

    if
        spellToCast and
        spellToCast > 0
    then
        return spellToCast, spellTarget
    end

    -- If no wounded allies, and not engaged, cast a buff.
    if not pet:isEngaged() then
        spellToCast, spellTarget = tryBuffSpell(pet)

        if
            spellToCast and
            spellToCast > 0
        then
            return spellToCast, spellTarget
        end
    end

    -- If no wounded allies, and engaged, cast an offensive spell.
    return nil, nil
end

-- Retreat from Engaged will trigger onMobDisengage.
xi.pets.avatar.onMobDisengage = function(pet)
    if pet:getPetID() == xi.petId.LIGHT_SPIRIT then
        local spellCooldown = getMagicCastCooldown(pet)

        pet:setMobMod(xi.mobMod.MAGIC_COOL, math.max(math.floor(spellCooldown / 2), 1))
    end
end
