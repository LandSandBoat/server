-----------------------------------
-- Area: Sealion's Den
--  Mob: Tenzen
-----------------------------------
local ID = zones[xi.zone.SEALIONS_DEN]
-----------------------------------
---@type TMobEntity
local entity = {}

local forms =
{
    SHEATHED = 3,
    MELEE    = 4,
    BOW_LOW  = 5,
    BOW_HIGH = 6,
}

local bowPhases =
{
    NONE  = 0,
    START = 1,
    FAST  = 2,
    SLOW  = 3,
}

local formTable =
{
    [forms.SHEATHED] = { skill = 0,    delay = 2000, standback = xi.behavior.NONE      },
    [forms.MELEE   ] = { skill = 0,    delay = 2000, standback = xi.behavior.NONE      },
    [forms.BOW_LOW ] = { skill = 2056, delay = 2400, standback = xi.behavior.STANDBACK },
    [forms.BOW_HIGH] = { skill = 2055, delay = 1500, standback = xi.behavior.STANDBACK },
}

local bowSequence =
{
    [bowPhases.START] = { form = forms.BOW_LOW,  minShots = 1, maxShots = 2,  nextPhase = bowPhases.FAST },
    [bowPhases.FAST ] = { form = forms.BOW_HIGH, minShots = 5, maxShots = 10, nextPhase = bowPhases.SLOW },
    [bowPhases.SLOW ] = { form = forms.BOW_LOW,  minShots = 1, maxShots = 5,  nextPhase = bowPhases.NONE },
}

local normalMeikyo =
{
    [0] = { xi.mobSkill.AMATSU_YUKIARASHI },
    [1] = { xi.mobSkill.AMATSU_TSUKIOBORO },
    [2] = { xi.mobSkill.AMATSU_HANAIKUSA },
}

local enrageMeikyo =
{
    [0] = { xi.mobSkill.AMATSU_HANAIKUSA   },
    [1] = { xi.mobSkill.AMATSU_TORIMAI     },
    [2] = { xi.mobSkill.AMATSU_KAZAKIRI    },
    [3] = { xi.mobSkill.AMATSU_TSUKIKAGE   },
    [4] = { xi.mobSkill.COSMIC_ELUCIDATION },
}

local taruOffsets =
{
    [ID.mob.MAKKI_CHEBUKKI] = ID.text.MAKKI_CHEBUKKI_OFFSET,
    [ID.mob.KUKKI_CHEBUKKI] = ID.text.KUKKI_CHEBUKKI_OFFSET,
    [ID.mob.CHERUKIKI     ] = ID.text.CHERUKIKI_OFFSET,
}

local function setupForm(mob, newForm)
    mob:setAnimationSub(newForm)
    mob:setMobSkillAttack(formTable[newForm].skill)
    mob:setDelay(formTable[newForm].delay)
    mob:setBehavior(formTable[newForm].standback)

    -- Pause for animation change before enabling auto attacks
    if newForm == forms.MELEE then
        mob:timer(1500, function(mobArg)
            mobArg:setAutoAttackEnabled(true)
            mobArg:setMobAbilityEnabled(true)
        end)
    end
end

-- Setup bow phase handling
local function setupBowPhase(mob, phase)
    local config = bowSequence[phase]

    setupForm(mob, config.form)

    mob:setLocalVar('[Tenzen]BowPhase', phase)
    mob:setLocalVar('[Tenzen]ShotCount', 0)
    mob:setLocalVar('[Tenzen]ShouldOisoya', 0)
    mob:setLocalVar('[Tenzen]TransitionActive', 0)
    mob:setLocalVar('[Tenzen]ShotAmount', math.random(config.minShots, config.maxShots))
end

local function wsSequence(mob)
    local step       = mob:getLocalVar('[Tenzen]MeikyoStep')
    local meikyoUsed = mob:getLocalVar('[Tenzen]MeikyoUsed')
    local skillchain = meikyoUsed == 1 and normalMeikyo or enrageMeikyo
    local maxSteps   = meikyoUsed == 1 and 2 or 4

    if step <= maxSteps then
        mob:setTP(1000)
        mob:useMobAbility(skillchain[step][1])
        mob:setLocalVar('[Tenzen]MeikyoStep', step + 1)
    else
        mob:setAutoAttackEnabled(true)
        mob:setMobAbilityEnabled(true)
        mob:setLocalVar('[Tenzen]MeikyoActive', 0)
        mob:setLocalVar('[Tenzen]MeikyoStep', 0)
    end
end

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DEF, 350)
    mob:setMod(xi.mod.REGAIN, 30)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    mob:setMobMod(xi.mobMod.SIGHT_RANGE, 10)
    mob:setUnkillable(true)

    -- Setup melee form.
    setupForm(mob, forms.MELEE)

    -- Reset local vars.
    mob:setLocalVar('[Tenzen]BowPhase', 0)
    mob:setLocalVar('[Tenzen]ShotCount', 0)
    mob:setLocalVar('[Tenzen]ShotAmount', 0)
    mob:setLocalVar('[Tenzen]ShouldOisoya', 0)
    mob:setLocalVar('[Tenzen]TransitionActive', 0)
    mob:setLocalVar('[Tenzen]MeikyoStep', 0)
    mob:setLocalVar('[Tenzen]MeikyoActive', 0)
    mob:setLocalVar('[Tenzen]MeikyoUsed', 0)
    mob:setLocalVar('[Tenzen]ShiftTimer', 0)
    mob:setLocalVar('[Tenzen]RiceBallTimer', 0)
    mob:setLocalVar('[Tenzen]LastWeaponskill', 0)
    mob:setLocalVar('[Tenzen]EnrageHP', math.random(25, 30))
    mob:setLocalVar('[Tenzen]MeikyoHP', math.random(60, 80))
end

entity.onMobEngage = function(mob, target)
    mob:showText(mob, ID.text.TENZEN_MSG_OFFSET) -- Engage message

    local currentTime = GetSystemTime()
    mob:setLocalVar('[Tenzen]ShiftTimer', currentTime + 40)
    mob:setLocalVar('[Tenzen]RiceBallTimer', currentTime + math.random(90, 120))

    -- Update Taru helpers enmity.
    local mobId = mob:getID()
    for taruId = mobId + 1, mobId + 3 do
        GetMobByID(taruId):updateEnmity(target)
    end
end

entity.onMobMobskillChoose = function(mob, target)
    local form         = mob:getAnimationSub()
    local shouldOisoya = mob:getLocalVar('[Tenzen]ShouldOisoya') == 1
    local skill        = 0
    local chosenSkill  = 0

    switch (form): caseof
    {
        [forms.MELEE] = function()
            local tpList =
            {
                xi.mobSkill.AMATSU_HANAIKUSA,
                xi.mobSkill.AMATSU_TSUKIKAGE,
                xi.mobSkill.AMATSU_TORIMAI,
                xi.mobSkill.AMATSU_KAZAKIRI,
                xi.mobSkill.AMATSU_YUKIARASHI,
                xi.mobSkill.AMATSU_TSUKIOBORO,
            }
            chosenSkill = tpList[math.random(1, #tpList)]
            skill = chosenSkill
        end,

        [forms.BOW_LOW] = function()
            if shouldOisoya then
                skill = xi.mobSkill.OISOYA
            else
                skill = xi.mobSkill.RANGED_ATTACK_TENZEN_1
            end
        end,

        [forms.BOW_HIGH] = function()
            if shouldOisoya then
                skill = xi.mobSkill.OISOYA
            else
                skill = xi.mobSkill.RANGED_ATTACK_TENZEN_2
            end
        end,
    }

    return skill
end

entity.onMobWeaponSkill = function(target, mob, skill)
    local skillId = skill:getID()

    -- Track last time Tenzen did a mobskill. Dont Meikyo Shisui immediately after.
    mob:setLocalVar('[Tenzen]LastWeaponskill', GetSystemTime() + 5)

    switch (skillId): caseof
    {
        [xi.mobSkill.COSMIC_ELUCIDATION] = function()
            mob:timer(2000, function(mobArg)
                mobArg:setAnimationSub(3)
                mobArg:showText(mobArg, ID.text.TENZEN_MSG_OFFSET + 1)
                mobArg:getBattlefield():lose()
            end)
        end,

        [xi.mobSkill.MEIKYO_SHISUI_1] = function()
            mob:setAutoAttackEnabled(false)
            mob:setMobAbilityEnabled(false)

            mob:setLocalVar('[Tenzen]MeikyoActive', 1)
            mob:setLocalVar('[Tenzen]MeikyoStep', 0)
            mob:setLocalVar('[Tenzen]ShiftTimer', GetSystemTime() + math.random(25, 70))
            setupForm(mob, forms.MELEE)
            wsSequence(mob)
        end,

        [xi.mobSkill.OISOYA] = function()
            mob:setLocalVar('[Tenzen]ShouldOisoya', 0)
        end,

        [xi.mobSkill.RANGED_ATTACK_TENZEN_1] = function()
            -- Increment shot count for bow attacks.
            mob:setLocalVar('[Tenzen]ShotCount', mob:getLocalVar('[Tenzen]ShotCount') + 1)
        end,

        [xi.mobSkill.RANGED_ATTACK_TENZEN_2] = function()
            -- Increment shot count for bow attacks.
            mob:setLocalVar('[Tenzen]ShotCount', mob:getLocalVar('[Tenzen]ShotCount') + 1)
        end,

        default = function()
            if mob:getLocalVar('[Tenzen]MeikyoActive') == 1 then
                wsSequence(mob)
            end
        end,
    }
end

entity.onMobFight = function(mob, target)
    local mobHPP = mob:getHPP()

    -- Win battle.
    if mobHPP <= 15 then
        mob:setAnimationSub(forms.SHEATHED)
        mob:showText(mob, ID.text.TENZEN_MSG_OFFSET + 2)

        local mobId = mob:getID()
        for taruId = mobId + 1, mobId + 3 do
            local taruMob = GetMobByID(taruId)
            local offset  = taruOffsets[taruId]
            if taruMob then
                taruMob:showText(taruMob, offset + 5)
            end
        end

        mob:timer(2000, function(mobArg)
            mobArg:getBattlefield():win()
        end)

        return
    end

    -- Enhance regain.
    if mobHPP <= 35 then
        mob:setMod(xi.mod.REGAIN, 70)
    end

    -- If mob is busy or otherwise unable to perform actions.
    if xi.combat.behavior.isEntityBusy(mob) then
        return
    end

    -- Only if in melee form, HP <= trigger, and not already used
    local meikyoHP = mob:getLocalVar('[Tenzen]MeikyoHP')
    local meikyoUsed = mob:getLocalVar('[Tenzen]MeikyoUsed')
    local form = mob:getAnimationSub()
    local lastWS = mob:getLocalVar('[Tenzen]LastWeaponskill') < GetSystemTime()
    if mobHPP <= meikyoHP and meikyoUsed == 0 and lastWS then
        if form == forms.MELEE then
            mob:setLocalVar('[Tenzen]MeikyoUsed', 1)
            mob:useMobAbility(xi.mobSkill.MEIKYO_SHISUI_1)

            return

        -- Loses ability to Meikyo if not in melee during trigger HP
        else
            mob:setLocalVar('[Tenzen]MeikyoUsed', 1)
        end
    end

    -- 5 min since engage or less than random enrage HP, start enrage weaponskill chain
    local enrageHP = mob:getLocalVar('[Tenzen]EnrageHP')
    if
        (mob:getBattleTime() >= 300 or mob:getHPP() <= enrageHP) and
        meikyoUsed < 2 and
        lastWS
    then
        mob:setLocalVar('[Tenzen]MeikyoUsed', 2)
        mob:useMobAbility(xi.mobSkill.MEIKYO_SHISUI_1)

        return
    end

    -- Melee form: wait for shift timer then begin bow sequence.
    local currentTime = GetSystemTime()
    if form == forms.MELEE then
        -- Rice ball
        local riceballTimer = mob:getLocalVar('[Tenzen]RiceBallTimer')
        if
            riceballTimer > 0 and
            currentTime >= riceballTimer
        then
            mob:useMobAbility(xi.mobSkill.RICEBALL_TENZEN)
            mob:setLocalVar('[Tenzen]RiceBallTimer', 0)
            mob:messageText(mob, ID.text.TENZEN_MSG_OFFSET + 3, false)

            return
        end

        if currentTime >= mob:getLocalVar('[Tenzen]ShiftTimer') then
            setupBowPhase(mob, bowPhases.START)
        end

        return
    end

    -- Bow forms: handle phase transitions based on shot count.
    if form == forms.BOW_LOW or form == forms.BOW_HIGH then
        local phase      = mob:getLocalVar('[Tenzen]BowPhase')
        local shotCount  = mob:getLocalVar('[Tenzen]ShotCount')
        local shotAmount = mob:getLocalVar('[Tenzen]ShotAmount')

        -- All shots fired, transition to next phase.
        if shotCount >= shotAmount then
            local phaseConfig = bowSequence[phase]

            -- Return to melee
            if not phaseConfig or phaseConfig.nextPhase == 0 then
                mob:setLocalVar('[Tenzen]ShiftTimer', currentTime + math.random(25, 70))
                mob:setLocalVar('[Tenzen]ShotCount', 0)
                mob:setLocalVar('[Tenzen]BowPhase', 0)
                setupForm(mob, forms.MELEE)

                return
            end

            -- Transition to next bow phase.
            mob:setLocalVar('[Tenzen]ShouldOisoya', 1)
            mob:timer(1500, function(mobArg)
                setupBowPhase(mob, phaseConfig.nextPhase)
            end)
        end
    end
end

return entity
