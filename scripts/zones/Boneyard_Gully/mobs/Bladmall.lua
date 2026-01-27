-----------------------------------
-- Area : Boneyard Gully
-- Mob  : Bladmall
-- ENM  : Shell We Dance?
-- NOTE : This Uragnite does not heal when going into its' shell. It should not use the Uragnite mixin.
-----------------------------------
---@type TMobEntity
local entity = {}
-----------------------------------
-- Enter/Exit Shell functions
-----------------------------------
local function enterShell(mob)
    mob:setAnimationSub(1)
    mob:setAutoAttackEnabled(false)
    mob:setMod(xi.mod.UDMGPHYS, -7500)
    mob:setMod(xi.mod.UDMGRANGE, -7500)
    mob:setMod(xi.mod.UDMGMAGIC, -7500)
    mob:setMod(xi.mod.UDMGBREATH, -7500)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    mob:setMagicCastingEnabled(false)
    mob:setLocalVar('shellExitTime', GetSystemTime() + math.random(50, 70))
    mob:useMobAbility(xi.mobSkill.VENOM_SHELL_1)
end

local function exitShell(mob)
    mob:setAnimationSub(0)
    mob:setAutoAttackEnabled(true)
    mob:setMod(xi.mod.UDMGPHYS, 0)
    mob:setMod(xi.mod.UDMGRANGE, 0)
    mob:setMod(xi.mod.UDMGMAGIC, 0)
    mob:setMod(xi.mod.UDMGBREATH, 0)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
    mob:setMagicCastingEnabled(true)
end

-----------------------------------
-- Pet Setup
-----------------------------------
local petOffsets = { 4, 5, 6 }

local callPetParams =
{
    dieWithOwner = true, -- Pets die when Bladmall dies.
    ignoreBusy = true,
    noAnimation = true,
    maxSpawns = 1,
}

local petSpawnTable =
{
    { hpp = 75, minDelay =  45, maxDelay =  90 }, -- 1st pet summoned at 75% HP or 45-90 seconds after engage.
    { hpp = 55, minDelay = 105, maxDelay = 150 }, -- 2nd pet summoned at 55% HP or 105-150 seconds after previous pet.
    { hpp = 35, minDelay = 105, maxDelay = 150 }, -- 3rd pet summoned at 35% HP or 105-150 seconds after previous pet.
}

-----------------------------------
-- onMobInitialize
-----------------------------------
entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.BLIND)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.PARALYZE)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.STUN)
    mob:setBehavior(xi.behavior.STANDBACK)
end

-----------------------------------
-- onMobSpawn
-----------------------------------
entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.REFRESH, 50)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 20)
    mob:setMobMod(xi.mobMod.STANDBACK_COOL, 0)
    mob:setMobMod(xi.mobMod.MAGIC_DELAY, math.random(3, 7))
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    mob:setLocalVar('petPhase', 1)
    mob:setLocalVar('nextPetTime', 0)
end

-----------------------------------
-- onMobFight
-----------------------------------
entity.onMobFight = function(mob)
    if xi.combat.behavior.isEntityBusy(mob) then
        return
    end

    local currentTime = GetSystemTime()

    -----------------------------------
    -- Check if it's time to exit shell
    -----------------------------------
    if
        mob:getAnimationSub() == 1 and
        currentTime >= mob:getLocalVar('shellExitTime')
    then
        exitShell(mob)
    end

    -----------------------------------
    -- Enrage at 15% HP or below
    -----------------------------------
    if
        mob:getHPP() <= 15 and
        mob:getLocalVar('enrage') == 0
    then
        mob:setLocalVar('enrage', 1)
        mob:injectActionPacket(mob:getID(), 11, 433, 0, 0x18, 0, 0, 0)
        mob:setMobMod(xi.mobMod.MAGIC_COOL, 5)
        mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 200)
    end

    -----------------------------------
    -- If all our pets have spawned, nothing else to do here
    -----------------------------------
    local phase = mob:getLocalVar('petPhase')
    if phase > #petSpawnTable then
        return
    end

    -----------------------------------
    -- Set up first pet timer/threshold on first mob tick
    -----------------------------------
    if
        mob:getLocalVar('nextPetTime') == 0 and
        phase == 1
    then
        mob:setLocalVar('nextPetTime', currentTime + math.random(petSpawnTable[1].minDelay, petSpawnTable[1].maxDelay))
        return
    end

    -----------------------------------
    -- Check to see if it's time to spawn a pet either via HP threshold or timer
    -----------------------------------
    if
        petSpawnTable[phase] and
        (mob:getHPP() <= petSpawnTable[phase].hpp or
        currentTime >= mob:getLocalVar('nextPetTime'))
    then
        enterShell(mob)

        local pets = {}
        for _, offset in ipairs(petOffsets) do
            table.insert(pets, mob:getID() + offset)
        end

        if xi.mob.callPets(mob, pets, callPetParams) then
            phase = phase + 1
            mob:setLocalVar('petPhase', phase)

            if petSpawnTable[phase] then
                mob:setLocalVar('nextPetTime', currentTime + math.random(petSpawnTable[phase].minDelay, petSpawnTable[phase].maxDelay))
            end
        end
    end
end

-----------------------------------
-- TP Moves - If in shell, use Venom Shell, otherwise, select from other skills
-----------------------------------
entity.onMobMobskillChoose = function(mob, target, skillId)
    if mob:getAnimationSub() == 1 then
        return xi.mobSkill.VENOM_SHELL_1
    end

    local skillList =
    {
        xi.mobSkill.GAS_SHELL_1,
        xi.mobSkill.PALSYNYXIS_1,
        xi.mobSkill.PAINFUL_WHIP_1,
        xi.mobSkill.SUCTORIAL_TENTACLE_1,
    }

    return skillList[math.random(1, #skillList)]
end

-----------------------------------
-- Spell Selection
-----------------------------------
entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [1] = { xi.magic.spell.WATER_IV,     target, false, xi.action.type.DAMAGE_TARGET,        nil,               0, 100 },
        [2] = { xi.magic.spell.WATERGA_III,  target, false, xi.action.type.DAMAGE_TARGET,        nil,               0, 100 },
        [3] = { xi.magic.spell.FLOOD,        target, false, xi.action.type.DAMAGE_TARGET,        nil,               0, 100 },
        [4] = { xi.magic.spell.CURE_V,       mob,    true,  xi.action.type.HEALING_TARGET,       50,                0, 100 },
        [5] = { xi.magic.spell.CURAGA_IV,    mob,    true,  xi.action.type.HEALING_FORCE_SELF,   50,                0, 100 },
        [6] = { xi.magic.spell.PROTECTRA_IV, mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.PROTECT, 0, 100 },
        [7] = { xi.magic.spell.SHELLRA_IV,   mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.SHELL,   0, 100 },
    }

    if mob:hasStatusEffectByFlag(xi.effectFlag.ERASABLE) then
        table.insert(spellList, #spellList + 1, { xi.magic.spell.ERASE, mob, true, xi.action.type.NONE, nil, 100 })
    end

    if target:hasStatusEffectByFlag(xi.effectFlag.DISPELABLE) then
        table.insert(spellList, #spellList + 1, { xi.magic.spell.DISPELGA, target, false, xi.action.type.NONE, nil, 100 })
    end

    local groupTable =
    {
        GetMobByID(mob:getID() - 1), -- Parata
        GetMobByID(mob:getID() + 1), -- Nepionic Parata
        GetMobByID(mob:getID() + 2), -- Nepionic Parata
        GetMobByID(mob:getID() + 3), -- Nepionic Parata
        GetMobByID(mob:getID() + 4), -- Nepionic Bladmall
        GetMobByID(mob:getID() + 5), -- Nepionic Bladmall
        GetMobByID(mob:getID() + 6), -- Nepionic Bladmall
    }

    return xi.combat.behavior.chooseAction(mob, target, groupTable, spellList)
end

return entity
