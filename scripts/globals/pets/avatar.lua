-----------------------------------
-- PET: Avatar
-----------------------------------
require('scripts/globals/summon')
-----------------------------------

xi = xi or {}
xi.pets = xi.pets or {}
xi.pets.avatar = {}

local buffModeVar          = 'AVATAR_BUFF_MODE_OFF'
local lastCastTimeVar      = 'AVATAR_LAST_CASTINGTIME'
local lastCastTimeStampVar = 'AVATAR_LAST_CAST_TIMESTAMP'
local playerListenerVar    = 'SMN_SPIRIT_CAST_DELAY'
local dummySpell           = xi.magic.spell.INDI_REGEN -- used to trigger a "valid" spell in TryCastSpell but not actually cast anything

local printDebug = function(pet, textToPrint)
    -- prints to map server if pet has local var
    if pet:getLocalVar('debug') == 1 then
        print(textToPrint)
    end
end

-- will determine, in seconds, the spirit's casting cooldown
-- Called every tick for player to adjust magic casting delay in real-time
local setMagicCastCooldown = function(pet)
    local castingCooldown = 45
    local master = pet:getMaster()

    -- we already know master is a PC, this is just in case the pet gets disjointed somehow
    if not master then
        return
    end

    castingCooldown = castingCooldown - math.floor(xi.summon.getSummoningSkillOverCap(pet) / 3)

    if master:hasStatusEffect(xi.effect.ASTRAL_FLOW) then
        castingCooldown = castingCooldown - 5
    end

    castingCooldown = castingCooldown - master:getMod(xi.mod.SPIRIT_CAST_REDUCTION)

    local petElement = master:getPetElement()

    -- AFAIK unaffected by scholar storms on the player, so we use weather of the pet
    local actorWeather = pet:getWeather()
    -- Strong weathers.
    if
        actorWeather == xi.combat.element.getAssociatedSingleWeather(petElement) or
        actorWeather == xi.combat.element.getAssociatedDoubleWeather(petElement)
    then
        castingCooldown = castingCooldown - 2
    -- Weak weathers.
    elseif
        actorWeather == xi.combat.element.getOppositeSingleWeather(petElement) or
        actorWeather == xi.combat.element.getOppositeDoubleWeather(petElement)
    then
        castingCooldown = castingCooldown + 2
    end

    local dayElement = VanadielDayElement()
    -- Strong day.
    if dayElement == petElement then
        castingCooldown = castingCooldown - 3
    -- Weak day.
    elseif dayElement == xi.combat.element.getOppositeElement(petElement) then
        castingCooldown = castingCooldown + 3
    end

    -- "Buff mode" is enabled for first cast after spawn and after casting any enhancing magic
    if pet:getLocalVar(buffModeVar) ~= 1 then
        castingCooldown = math.floor(castingCooldown / 2)
    end

    -- cast delay is ~1s past the finish of last spell, so we add casting time (or time since spell interrupt) to the castingCooldown
    -- this is done by simply tracking the elapsed time since action is no longer xi.action.MAGIC_CASTING
    local lastCastTime = pet:getLocalVar(lastCastTimeVar)
    local lastCastTimeStamp = pet:getLocalVar(lastCastTimeStampVar)
    if
        lastCastTimeStamp > 0 and
        os.time() - lastCastTimeStamp > lastCastTime
    then
        lastCastTime = os.time() - lastCastTimeStamp
    end

    if
        lastCastTime > 0 and
        pet:getCurrentAction() ~= xi.action.MAGIC_CASTING
    then
        pet:setLocalVar(lastCastTimeStampVar, 0)
        pet:setLocalVar(lastCastTimeVar, lastCastTime)
    end

    pet:setMobMod(xi.mobMod.MAGIC_COOL, lastCastTime + math.max(castingCooldown, 0))
end

xi.pets.avatar.onMobSpawn = function(pet)
    local master = pet:getMaster()
    if
        not master or
        master:getObjType() ~= xi.objType.PC
    then
        return
    end

    -- add listener to player to fine-tune spirit pact cast delays in realtime
    if
        pet:getPetID() <= xi.petId.DARK_SPIRIT
    then
        -- stops the pet from immediately casting a spell on spawn and respecting the cooldowns by exiting early if MAGIC_COOL is 1
        pet:setMobMod(xi.mobMod.MAGIC_COOL, 1)
        pet:setMod(xi.mod.MPP, 500)
        pet:updateHealth()
        pet:setMP(pet:getMaxMP())

        master:addListener('TICK', playerListenerVar, function(playerArg)
            local petArg = playerArg:getPet()

            if petArg and petArg:getMobMod(xi.mobMod.MAGIC_COOL) > 1 then
                setMagicCastCooldown(petArg)
            end
        end)

        master:addListener('ABILITY_USE', playerListenerVar .. 'ABILITY', function(playerArg, target, ability, action)
            local petArg = playerArg:getPet()
            local abilityID = ability:getID()

            if
                petArg and
                (abilityID == xi.jobAbility.ASSAULT or
                abilityID == xi.jobAbility.RETREAT)
            then
                printDebug(petArg, 'resetting cast cooldown')
                -- reset cast cooldown via same method as fresh spawn
                petArg:setMobMod(xi.mobMod.MAGIC_COOL, 1)
                petArg:setLocalVar(buffModeVar, 1)
            end
        end)
    end
end

xi.pets.avatar.onMobDeath = function(pet)
    local master = pet:getMaster()

    if master and master:getObjType() == xi.objType.PC then
        master:removeListener(playerListenerVar)
        master:removeListener(playerListenerVar .. 'ABILITY')
    end
end

xi.pets.avatar.onMobMagicPrepare = function(pet)
    -- Note that:
    -- returning -1 (or a spell the spirit cannot cast) in this function forces TryCastSpell to exit without choosing/casting a spell, but
    -- will still set the m_LastMagicTime to ensure next call of this function is after the cast delay
    -- Also, if we return nothing (or zero) TryCastSpell will default to normal mob casting behavior (nukes from spell list, etc)
    printDebug(pet, string.format('onMobMagicPrepare: %u', pet:getMobMod(xi.mobMod.MAGIC_COOL))) -- for debugging magic cooldown
    local master = pet:getMaster()
    if
        not master or
        master:getObjType() ~= xi.objType.PC
    then
        return
    end

    -- meta checks for fresh pet, etc
    pet:setLocalVar(lastCastTimeVar, 0)
    pet:setLocalVar(lastCastTimeStampVar, os.time())

    -- early exit from casting a spell to prevent immediately casting a spell after being summoned
    if pet:getMobMod(xi.mobMod.MAGIC_COOL) == 1 then
        setMagicCastCooldown(pet)

        return dummySpell
    end

    -- ensures magic casting delay is no longer halved
    pet:setLocalVar(buffModeVar, 1)

    -- Core functionality to decide which spell to use
    local spellID, spellTarget = xi.pets.avatar.getSpiritSpell(pet)

    -- Final items to cast the spell and ensure cast delay is proper
    local spell = GetSpell(spellID)
    if spell then
        if spell:getSkillType() == xi.skill.ENHANCING_MAGIC then
            -- half casting delay
            pet:setLocalVar(buffModeVar, 0)
        end

        pet:castSpell(spellID, spellTarget or pet)
        setMagicCastCooldown(pet)

        return dummySpell
    end

    return 0
end

---@param pet CBaseEntity
---@return integer, CBaseEntity?
xi.pets.avatar.getSpiritSpell = function(pet)
    local spellID = 0
    local spellTarget = nil
    local petID = pet:getPetID()
    -- add more logic as needed with its own function
    if petID == xi.petId.LIGHT_SPIRIT then
        -- TODO: Align spirit and light spirit functions for return consistency and consolidate.
        spellID, spellTarget = xi.pets.avatar.getLightSpiritSpell(pet)
    end

    return spellID, spellTarget
end

xi.pets.avatar.lightSpiritBuffs =
{
    [xi.effect.PROTECT] =
    {
        {
            spell = xi.magic.spell.PROTECT_V,
            power = 220,
            level = 76,
        },
        {
            spell = xi.magic.spell.PROTECT_IV,
            power = 140,
            level = 68,
        },
        {
            spell = xi.magic.spell.PROTECT_III,
            power = 90,
            level = 47,
        },
        {
            spell = xi.magic.spell.PROTECT_II,
            power = 50,
            level = 27,
        },
        {
            spell = xi.magic.spell.PROTECT,
            power = 20,
            level = 7,
        },
    },
    [xi.effect.SHELL] =
    {
        {
            spell = xi.magic.spell.SHELL_V,
            power = 2930,
            level = 76,
        },
        {
            spell = xi.magic.spell.SHELL_IV,
            power = 2617,
            level = 68,
        },
        {
            spell = xi.magic.spell.SHELL_III,
            power = 2188,
            level = 57,
        },
        {
            spell = xi.magic.spell.SHELL_II,
            power = 1641,
            level = 37,
        },
        {
            spell = xi.magic.spell.SHELL,
            power = 1055,
            level = 10,
        },
    },
    [xi.effect.REGEN] =
    {
        {
            spell = xi.magic.spell.REGEN,
            power = 0, -- Light spirit does not overwrite
            level = 21,
        },
    },
    [xi.effect.HASTE] =
    {
        {
            spell = xi.magic.spell.HASTE,
            power = 0, -- Light spirit does not overwrite
            level = 48,
        },
    },
}

xi.pets.avatar.lightSpiritCures =
{
    [xi.magic.spellFamily.CURE] =
    {
        {
            spell = xi.magic.spell.CURE_VI,
            level = 80,
        },
        {
            spell = xi.magic.spell.CURE_V,
            level = 61,
        },
        {
            spell = xi.magic.spell.CURE_IV,
            level = 41,
        },
        {
            spell = xi.magic.spell.CURE_III,
            level = 21,
        },
        {
            spell = xi.magic.spell.CURE_II,
            level = 11,
        },
        {
            spell = xi.magic.spell.CURE,
            level = 1,
        },
    },
    [xi.magic.spellFamily.CURAGA] =
    {
        {
            spell = xi.magic.spell.CURAGA_V,
            level = 91,
        },
        {
            spell = xi.magic.spell.CURAGA_IV,
            level = 71,
        },
        {
            spell = xi.magic.spell.CURAGA_III,
            level = 51,
        },
        {
            spell = xi.magic.spell.CURAGA_II,
            level = 31,
        },
        {
            spell = xi.magic.spell.CURAGA,
            level = 16,
        },
    },
}

xi.pets.avatar.getLightSpiritBuffs = function(pet)
    -- returns a table of the highest-tier buffs available to this light spirit pet
    local petLvl = pet:getMainLvl()
    local buffs = {}
    for effect, buffData in pairs(xi.pets.avatar.lightSpiritBuffs) do
        -- loop over every spell for this effect and exit on the first that the pet can cast
        for _, spellData in ipairs(buffData) do
            if petLvl >= spellData.level then
                table.insert(buffs, {
                    effect = effect,
                    spell = spellData.spell,
                    power = spellData.power
                })
                break
            end
        end
    end

    return buffs
end

xi.pets.avatar.getLightSpiritCure = function(pet)
    -- curaga can be used on anyone in the alliance and isn't determined by how many need a heal (assumed to be based on skill over cap)
    local petLvl = pet:getMainLvl()
    local spellFamily = xi.magic.spellFamily.CURE
    if
        petLvl >= 16 and
        math.random(100) <= 2 * xi.summon.getSummoningSkillOverCap(pet)
    then
        spellFamily = xi.magic.spellFamily.CURAGA
    end

    for _, spellData in ipairs(xi.pets.avatar.lightSpiritCures[spellFamily]) do
        if petLvl >= spellData.level then
            return spellData.spell
        end
    end

    return 0
end

xi.pets.avatar.getLightSpiritSpell = function(pet)
    -- returns the spirit's preferred target based on positioning
    local master = pet:getMaster()
    if not master then
        return 0, nil
    end

    local posTarget = nil
    local posSpellID = 0
    local buffTarget = nil
    local buffSpellID = 0
    local cureTarget = nil
    local spellID = 0

    if not pet:isEngaged() then
        pet:lookAt(master:getPos())
    else
        -- don't do logic to buff anyone if pet is engaged. buffTarget will be reset below
        buffTarget = master
    end

    local distance  = pet:checkDistance(master) -- starts as distance to master, updated to be distance to the posTarget
    local hpp       = 100
    local alliance  = master:getAlliance()
    local party     = master:getParty()

    for _, member in pairs(alliance) do
        local tempHPP = member:getHPP()
        if
            pet:checkDistance(member) < 20 and
            tempHPP < hpp
        then
            -- tiered chance of healing based on how low they are
            -- flip a coin for every 25% hp the player has missing
            for hpColor = 1, 3 do
                if
                    tempHPP < 25 * hpColor and
                    math.random(1, 100) <= 50
                then
                    hpp = tempHPP
                    cureTarget = member

                    break
                end
            end
        end
    end

    if cureTarget then
        spellID = xi.pets.avatar.getLightSpiritCure(pet)

        return spellID, cureTarget
    else
        local lightSpiritBuffs = xi.pets.avatar.getLightSpiritBuffs(pet)

        for _, member in pairs(party) do
            local tempDistance = pet:checkDistance(member)
            if
                not member:hasStatusEffect(xi.effect.INVISIBLE) and
                (tempDistance <= distance or
                not buffTarget)
            then
                -- Light Spirit will overwrite lower tiered Protect and Shell spells but will not overwrite Haste or Regen
                local tempSpellID = 0

                for _, spellData in ipairs(lightSpiritBuffs) do
                    if
                        not member:getStatusEffect(spellData.effect) or
                        member:getStatusEffect(spellData.effect):getPower() < spellData.power
                    then
                        -- exit loop once a buff is found to be applied
                        tempSpellID = spellData.spell

                        break
                    end
                end

                if tempSpellID > 0 and tempDistance < 20 then
                    if
                        tempDistance < distance and
                        pet:isFacing(member)
                    then
                        posSpellID = tempSpellID
                        distance = tempDistance
                        posTarget = member
                    elseif not buffTarget then
                        buffSpellID = tempSpellID
                        buffTarget = member
                    end
                end
            end
        end

        -- only buff in combat if positioning is encouraging it
        if pet:isEngaged() then
            buffTarget = nil
            buffSpellID = 0
        end

        if posTarget then
            buffTarget = posTarget
            spellID = posSpellID
        else
            spellID = buffSpellID
        end

        return spellID, buffTarget
    end
end
