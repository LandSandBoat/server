-----------------------------------
-- Area: The Garden of Ru'Hmet
--  Mob: Ix'zdei (Red Mage)
-- Note: CoP Mission 8-3
-----------------------------------
local ID = zones[xi.zone.THE_GARDEN_OF_RUHMET]
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

local forms =
{
    IDLE  = 0,
    POT   = 1,
    POLES = 2,
    RINGS = 3,
}

local pathPoints =
{
    [ID.mob.IXZDEI_RDM    ] = { x = 422.085, y = 0.000, z = 426.928 },
    [ID.mob.IXZDEI_RDM + 1] = { x = 417.964, y = 0.000, z = 426.938 },
}

local changeForm = function(mob)
    local currentForm = mob:getAnimationSub()
    local possibleForms = {}
    for i = forms.POT, forms.RINGS do
        if i ~= currentForm then
            table.insert(possibleForms, i)
        end
    end

    local newForm = possibleForms[math.random(1, #possibleForms)]
    mob:setAnimationSub(newForm)
end

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.PARALYZE)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.TERROR)
    mob:setMobMod(xi.mobMod.ROAM_DISTANCE, 0)
    mob:setMobMod(xi.mobMod.MAGIC_DELAY, 5)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    mob:setLocalVar('healPercent', math.random(15, 25))

    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.jsa.MANAFONT, hpp = math.random(50, 80) },
        },
    })
end

entity.onMobEngage = function(mob, target)
    mob:setLocalVar('nextChangeTime', GetSystemTime() + math.random(15, 45))
    mob:setAnimationSub(forms.POT)

    -- Mob paths off of alcove before casting
    local mobID = mob:getID()
    mob:pathTo(pathPoints[mobID].x, pathPoints[mobID].y, pathPoints[mobID].z)
end

entity.onMobFight = function(mob, target)
    if xi.combat.behavior.isEntityBusy(mob) then
        return
    end

    -- Paths to designated location and begins casting
    if
        mob:getLocalVar('reachedStart') == 0 and
        not mob:isFollowingPath()
    then
        mob:setLocalVar('reachedStart', 1)
        mob:castSpell()
    end

    -- Change forms at random intervals if not charging Optic Induration
    if
        GetSystemTime() > mob:getLocalVar('nextChangeTime') and
        mob:getLocalVar('chargeCount') == 0
    then
        changeForm(mob)
        mob:setLocalVar('nextChangeTime', GetSystemTime() + math.random(15, 45))
    end
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    local form = mob:getAnimationSub()
    local tpMoves = { xi.mobSkill.REACTOR_COOL }

    switch (form): caseof
    {
        [forms.POT] = function()
            if math.random(1, 100) <= 75 then
                table.insert(tpMoves, xi.mobSkill.OPTIC_INDURATION_CHARGE)
            end
        end,

        [forms.POLES] = function()
            table.insert(tpMoves, xi.mobSkill.STATIC_FILAMENT)
            table.insert(tpMoves, xi.mobSkill.DECAYED_FILAMENT)
        end,

        [forms.RINGS] = function()
            table.insert(tpMoves, xi.mobSkill.REACTOR_OVERLOAD)
            table.insert(tpMoves, xi.mobSkill.REACTOR_OVERHEAT)
        end,
    }

    return tpMoves[math.random(1, #tpMoves)]
end

entity.onMobWeaponSkill = function(target, mob, skill)
    -- Handle healing completion
    if skill:getID() == xi.mobSkill.OPTIC_INDURATION_CHARGE then
        local chargeCount = mob:getLocalVar('chargeCount')
        local chargeTotal = mob:getLocalVar('chargeTotal')

        if chargeTotal > 0 and chargeCount == chargeTotal then
            mob:useMobAbility(xi.mobSkill.OPTIC_INDURATION, mob:getTarget())
        else
            if chargeCount == 0 then
                mob:setAutoAttackEnabled(false)
                mob:setMagicCastingEnabled(false)
                mob:setLocalVar('chargeTotal', 3)
            end

            chargeCount = chargeCount + 1
            mob:setLocalVar('chargeCount', chargeCount)
            mob:useMobAbility(xi.mobSkill.OPTIC_INDURATION_CHARGE)
        end

    elseif skill:getID() == xi.mobSkill.OPTIC_INDURATION then
        mob:setAutoAttackEnabled(true)
        mob:setMagicCastingEnabled(true)
        mob:setLocalVar('chargeCount', 0)
        mob:setLocalVar('chargeTotal', 0)
    end
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local isLight = mob:getID() == ID.mob.IXZDEI_RDM

    local spellListLight =
    {
        [1] = { xi.magic.spell.CURE_V,    mob,    true,  xi.action.type.HEALING_TARGET,    33,                0, 100 },
        [2] = { xi.magic.spell.REGEN,     mob,    true,  xi.action.type.ENHANCING_TARGET,  xi.effect.REGEN,   0, 100 },
        [3] = { xi.magic.spell.GRAVITY,   target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.WEIGHT,  0, 100 },
        [4] = { xi.magic.spell.DIAGA_II,  target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.DIA,     0, 100 },
        [5] = { xi.magic.spell.SILENCEGA, target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.SILENCE, 0, 100 },
        [6] = { xi.magic.spell.FLASH,     target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.FLASH,   0, 100 },
    }

    local spellListDark =
    {
        [1] = { xi.magic.spell.POISON_II, target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.POISON,    0, 100 },
        [2] = { xi.magic.spell.BIO_III,   target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.BIO,       0, 100 },
        [3] = { xi.magic.spell.BLIND,     target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.BLINDNESS, 0, 100 },
        [5] = { xi.magic.spell.BINDGA,    target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.BIND,      0, 100 },
        [4] = { xi.magic.spell.DISPELGA,  target, false, xi.action.type.DAMAGE_TARGET,     nil,                 0, 100 },
    }

    local groupTableLight =
    {
        GetMobByID(mob:getID() + 1), -- Ix'zdei RDM
        GetMobByID(mob:getID() + 2), -- Ix'zdei BLM
        GetMobByID(mob:getID() + 3), -- Ix'zdei BLM
    }

    local groupTableDark =
    {
        GetMobByID(mob:getID() - 1), -- Ix'zdei RDM
        GetMobByID(mob:getID() + 1), -- Ix'zdei BLM
        GetMobByID(mob:getID() + 2), -- Ix'zdei BLM
    }

    local spellList  = isLight and spellListLight or spellListDark
    local groupTable = isLight and groupTableLight or groupTableDark
    return xi.combat.behavior.chooseAction(mob, target, groupTable, spellList)
end

entity.onMobDisengage = function(mob)
    mob:setAnimationSub(forms.IDLE)
    mob:setLocalVar('reachedStart', 0) -- Reset on disengage
end

return entity
