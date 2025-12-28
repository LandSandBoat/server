-----------------------------------
-- Area: Aydeewa Subterrane
--  ZNM: Pandemonium Warden for intermediate phases
-- Note: This mob is respawned every HNM phase and enmity is fresh
--       Medusa uses eagle eye shot, safe to say each phase has the respective 2hr?
--
-- Outline of fight:
--    Each phase has an increasing amount of HP
--    In-between phases the real PW shows up (not this mob), and is hard-coded to use cackle, then hellsnap, then change to next phase.
--      During this sequence, no damage can be inflicted, and pets do not do anything except follow the primary target
--    Each phase, this mob has the job's respective 2-hour ability at 70% of the starting HP
--
--    If a full wipe happens, DoT will keep PW from regen, which will keep him in current form. If he regens to full HP, he resets to phase 1
--    In each phase, he has access to the respective mobskills and spells of the mob he's mimicing
--      Pet forms vary depending on what mob the Warden is currently mimicking
--      No phases seem to use AoE elemental magic
-----------------------------------
mixins = { require('scripts/mixins/draw_in') }
local ID = zones[xi.zone.AYDEEWA_SUBTERRANE]
-----------------------------------
---@type TMobEntity
local entity = {}

---@class phaseRow
---@field mobHP integer
---@field mobModelId integer
---@field mobSkillList integer
---@field mobSpecial string
---@field mobSpellList integer
---@field petModelId integer
---@field petSkillList integer
---@field petSpellLists table<integer>
local phaseRow = {}
phaseRow.__index = phaseRow

---@param mobHP integer
---@param mobModelId integer
---@param mobSkillList integer
---@param mobSpecial string
---@param mobSpellList integer
---@param petModelId integer
---@param petSkillList integer
---@param petSpellLists table<integer>
---@return phaseRow
phaseRow.new = function(mobHP, mobModelId, mobSkillList, mobSpecial, mobSpellList, petModelId, petSkillList, petSpellLists)
    local self = setmetatable({}, phaseRow)
    self.mobHP = mobHP
    self.mobModelId = mobModelId
    self.mobSkillList = mobSkillList
    self.mobSpecial = mobSpecial
    self.mobSpellList = mobSpellList
    self.petModelId = petModelId
    self.petSkillList = petSkillList
    self.petSpellLists = petSpellLists
    return self
end

-- Table of phase data, with LLS hints above so we can reliably know phaseTable[3].mobSkillList is an int, etc
local phaseTable = {
    phaseRow.new(10000, 1825, 1000, 'MIGHTY_STRIKES',   0, 1820,  150, { 0 }),             -- Armed Chariot          pets: Archaic Gears (Melee only)
    phaseRow.new(10000, 1824, 1001, 'MIGHTY_STRIKES',   0, 1820,  150, { 0 }),             -- Battle Chariot         pets: Archaic Gears (Melee only)
    phaseRow.new(10000, 1822, 1002, 'MIGHTY_STRIKES',   0, 1820,  150, { 0 }),             -- Armored Chariot        pets: Archaic Gears (Melee only)
    phaseRow.new(10000, 1823, 1003, 'MIGHTY_STRIKES',   0, 1820,  150, { 0 }),             -- Bowed Chariot          pets: Archaic Gears (Melee only)
    phaseRow.new(15000, 1863,  285, 'MIJIN_GAKURE',   563, 1639,  176, { 560, 562, 563 }), -- Gulool Ja Ja           pets: Mamool Ja (some cast blm, some cast whm, some cast ninjutsu)
    phaseRow.new(15000, 1865,  725, 'EES_LAMIA',        0, 1643,  171, { 0, 561 }),        -- Medusa                 pets: Lamiae (some cast rdm spells)
    phaseRow.new(15000, 1867,  326, 'HUNDRED_FISTS',    0, 1682,  246, { 0, 0, 560 }),     -- Gurfurlur the Menacing pets: Trolls (some cast whm spells, but not half)
    phaseRow.new(20000, 1805,  168, 'MIGHTY_STRIKES',   0, 1746,  198, { 0 }),             -- Khimaira               pets: Puks (Melee only)
    phaseRow.new(20000, 1796,  164, 'MIGHTY_STRIKES',   0,  421, 2007, { 0 }),             -- Hydra                  pets: Dahaks (Melee only)
    phaseRow.new(20000, 1793,   62, 'MIGHTY_STRIKES',   0,  281, 2039, { 0 }),             -- Cerberus               pets: Bombs (Melee only)
    -- Dvergr - pets: Miniature Dvergr All cast blm spells (not this mob, but listed here for completion's sake)
}

entity.onMobInitialize = function(mob)
    -- "If all individuals who have developed enmity die, Pandemonium Warden will return to his spawn point, with his train of lamps, and will not be aggressive to any non-combat action"
    mob:setAggressive(false)

    mob:setMobMod(xi.mobMod.NO_DROPS, 1)
    mob:setMod(xi.mod.STATUSRES, 50)

    mob:setMobMod(xi.mobMod.ALLI_HATE, 30)
    mob:setMobMod(xi.mobMod.HP_STANDBACK, 0)

    -- this mob is always unkillable, simply despawns when "defeated"
    mob:setUnkillable(true)
end

local despawnPW = function(mob)
    if mob and mob:isSpawned() then
        DespawnMob(mob:getID())
    end

    for _, petId in ipairs(ID.mob.PANDEMONIUM_LAMPS) do
        local pet = GetMobByID(petId)
        -- dead pets stay grey, living pets despawn immediately
        if pet then
            -- spawn listener will be added when next phase starts
            pet:removeListener('SET_PET_PROPERTIES')

            if pet:isAlive() then
                DespawnMob(petId)
                pet:setAutoAttackEnabled(false)
                pet:setMobAbilityEnabled(false)
                pet:setMagicCastingEnabled(false)
            end
        end
    end
end

entity.onMobRoam = function(mob)
    if
        mob:getHPP() == 100 and
        not xi.combat.behavior.isEntityBusy(mob)
    then
        despawnPW(mob)
        return
    end
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DEF, 450)
    mob:setMod(xi.mod.MEVA, 380)
    mob:setMod(xi.mod.MDEF, 50)

    -- get phase number from main PW
    local pw = GetMobByID(ID.mob.PANDEMONIUM_WARDEN)
    local phase = pw and pw:getLocalVar('phase') or 0
    local phaseData = phaseTable[phase]
    if not pw or not phaseData then
        despawnPW(mob)
        return
    end

    -- adjust skill/spell/model of PW and PL mobs
    mob:setAnimationSub(0)
    mob:setMaxHP(phaseData.mobHP)
    mob:setModelId(phaseData.mobModelId)
    mob:setMobMod(xi.mobMod.SKILL_LIST, phaseData.mobSkillList)
    mob:setLocalVar('twoHourSkill', xi.jobSpecialAbility[phaseData.mobSpecial] or 0)
    mob:setMobMod(xi.mobMod.SPELL_LIST, phaseData.mobSpellList)
    if mob:getMobMod(xi.mobMod.SPELL_LIST) == 0 then
        mob:setMagicCastingEnabled(false)
    else
        mob:setMagicCastingEnabled(true)
    end

    -- final 3 HNM phases
    if phase >= 8 then
        mob:setBehavior(bit.bor(mob:getBehavior(), xi.behavior.NO_TURN))

        -- Hydra phase
        if phase == 9 then
            mob:setLocalVar('critsRemaining', math.random(10, 30))
        end
    else
        mob:setBehavior(bit.band(mob:getBehavior(), bit.bnot(xi.behavior.NO_TURN)))
    end

    for _, petId in ipairs(ID.mob.PANDEMONIUM_LAMPS) do
        local pet = GetMobByID(petId)
        if pet then
            local petModel = phaseData.petModelId
            local skillList = phaseData.petSkillList
            -- not all pets each phase use spells. Spell List 0 is included in each pet's SpellLists table to account for this
            local spellList = utils.randomEntry(phaseData.petSpellLists)

            -- skill/spell list has to be set after spawn
            pet:addListener('SPAWN', 'SET_PET_PROPERTIES', function(petArg)
                petArg:setModelId(petModel)
                petArg:setMobMod(xi.mobMod.SKILL_LIST, skillList)
                petArg:setMobMod(xi.mobMod.HP_STANDBACK, 0)
                if spellList == 0 then
                    petArg:setMagicCastingEnabled(false)
                else
                    petArg:setSpellList(spellList)
                    petArg:setMagicCastingEnabled(true)
                end

                petArg:setAutoAttackEnabled(true)
                petArg:setMobAbilityEnabled(true)
            end)
        end
    end

    -- TODO can he call more pets during HNM phases?
    local callPetParams =
    {
        noAnimation = true,
        maxSpawns = 6,
        ignoreBusy = true,
    }
    mob:timer(2000, function(mobArg)
        xi.mob.callPets(mobArg, ID.mob.PANDEMONIUM_LAMPS, callPetParams)
    end)

    -- intermediate PW forms spawn claimed but don't attack for up to 4s after phase change
    local pwTarget = pw:getTarget()
    if pwTarget then
        mob:updateClaim(pwTarget)
    end

    mob:stun(2000)
end

entity.onMobDisengage = function(mob)
end

entity.onMobEngage = function(mob, target)
end

entity.onCriticalHit = function(mob)
    local critsRemaining = mob:getLocalVar('critsRemaining')
    local animationSub = mob:getAnimationSub()

    if critsRemaining == 0 then
        return
    end

    critsRemaining = critsRemaining - 1
    if critsRemaining <= 0 then  -- Lose a head
        -- TODO can he re-grow heads?
        if animationSub < 2 then
            mob:setAnimationSub(animationSub + 1)
        end

        -- Number of crits to lose a head, re-randoming
        critsRemaining = math.random(10, 30)
    end

    mob:setLocalVar('critsRemaining', critsRemaining)
end

entity.onMobFight = function(mob, target)
    local mobHPP    = mob:getHPP()
    local twoHour = mob:getLocalVar('twoHourSkill')
    if not xi.combat.behavior.isEntityBusy(mob) then
        if mobHPP <= 1 then
            -- despawn PW phase and interrupt all pets
            despawnPW(mob)

            return
        end

        if
            mobHPP <= 70 and
            twoHour > 0
        then
            mob:setLocalVar('twoHourSkill', 0)
            mob:useMobAbility(twoHour)
        end
    end
end

entity.onMobDespawn = function(mob)
    despawnPW(mob)

    -- adjust PW phase and unhide main mob
    local pw = GetMobByID(ID.mob.PANDEMONIUM_WARDEN)
    if pw then
        if mob:getHPP() == 100 then
            -- mob was despawned from being full hp after a wipe, reset fight
            pw:setLocalVar('phase', 1)
        else
            pw:setLocalVar('phase', pw:getLocalVar('phase') + 1)
        end

        if pw:isAlive() then
            -- reappear
            pw:setPos(mob:getPos())
            pw:timer(3000, function(mobArg)
                mobArg:triggerListener('UNHIDE', mobArg)
            end)
        end
    end
end

return entity
