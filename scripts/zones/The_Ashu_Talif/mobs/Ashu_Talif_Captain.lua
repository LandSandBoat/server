-----------------------------------
-- Area: The Ashu Talif (The Black Coffin)
--   NM: Ashu Talif Captain
-----------------------------------
local ID = zones[xi.zone.THE_ASHU_TALIF]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.ASPIR)
end

entity.onMobSpawn = function(mob)
    mob:setUnkillable(true)
    mob:hideName(true)
    mob:setMod(xi.mod.REGAIN, 35)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)

    mob:setLocalVar('[2hour]HPP', math.random(25, 35))
    mob:setLocalVar('[2hour]Used', 0)
    mob:setLocalVar('vulcanTimer', 0)
end

entity.onMobEngage = function(mob, target)
    mob:setLocalVar('vulcanTimer', GetSystemTime() + 60)
end

entity.onMobFight = function(mob, target)
    local instance = mob:getInstance()
    if not instance then
        return
    end

    if instance:completed() then
        return
    end

    -- The captain gives up at <= 20% HP. Everyone disengages.
    local mobHPP = mob:getHPP()
    if mobHPP <= 20 then
        instance:complete()
    end

    if xi.combat.behavior.isEntityBusy(mob) then
        return
    end

    -- 2 Hour.
    if
        mob:getLocalVar('[2hour]Used') == 0 and
        mobHPP < mob:getLocalVar('[2hour]HPP')
    then
        mob:setLocalVar('[2hour]Used', 1)
        mob:useMobAbility(xi.mobSkill.WILD_CARD)
        return
    end

    -- Vulcan shot.
    local currentTime = GetSystemTime()
    if currentTime >= mob:getLocalVar('vulcanTimer') then
        mob:setLocalVar('vulcanTimer', currentTime + 60)
        mob:useMobAbility(xi.mobSkill.VULCAN_SHOT, nil, 2000)
        return
    end
end

entity.onMobMobskillChoose = function(mob, target)
    local tpList =
    {
        xi.mobSkill.VORPAL_BLADE_1,
        xi.mobSkill.FLAT_BLADE_1,
        xi.mobSkill.FAST_BLADE_1,
        xi.mobSkill.BURNING_BLADE_1,
        xi.mobSkill.RED_LOTUS_BLADE_1,
        xi.mobSkill.SHINING_BLADE_1,
        xi.mobSkill.SERAPH_BLADE_1,
        xi.mobSkill.CIRCLE_BLADE_1,
    }

    -- Switch to ranged WS if target is out of melee range.
    -- TODO: Implement ranged WS after physical mobskill rework
    -- if mob:checkDistance(target) > 5.6 then
    --     return utils.randomEntry({
    --         xi.mobSkill.HOT_SHOT_1,
    --         xi.mobSkill.SPLIT_SHOT_1,
    --         xi.mobSkill.SNIPER_SHOT_1,
    --         xi.mobSkill.SLUG_SHOT_1,
    --     })
    -- end

    return utils.randomEntry(tpList)
end

entity.onMobWeaponSkill = function(mob, target, skill, action)
    local instance = mob:getInstance()
    if not instance then
        return
    end

    local skillId = skill:getID()

    if skillId ~= xi.mobSkill.VULCAN_SHOT then
        mob:showText(mob, ID.text.FOR_THE_BLACK_COFFIN)
        return
    end

    mob:showText(mob, ID.text.FOR_EPHRAMAD)

    -- Check if Gessho is able to interrupt
    local gessho = GetMobByID(ID.mob.GESSHO, instance)
    if
        not gessho or
        not gessho:isAlive() or
        xi.combat.behavior.isEntityBusy(gessho)
    then
        return
    end

    -- Dice roll to determine if Gessho will attempt to interrupt
    if math.random(1, 100) > 25 then
        return
    end

    gessho:setLocalVar('vulcanInterrupt', 1)
    gessho:useMobAbility(xi.mobSkill.WARP_OUT_GESSHO, nil, 0)

    -- Hysteria is used to disallow the Captain from completing the Vulcan Shot
    local pTable =
    {
        duration = 5,
        origin   = mob,
        flag     = xi.effectFlag.NO_LOSS_MESSAGE,
        silent   = true
    }

    mob:addStatusEffect(xi.effect.HYSTERIA, pTable)

    local hysteriaEffect = mob:getStatusEffect(xi.effect.HYSTERIA)
    if hysteriaEffect then
        hysteriaEffect:delEffectFlag(xi.effectFlag.DISPELABLE)
    end

    mob:timer(1000, function(captain)
        captain:showText(captain, ID.text.TROUBLESOME_SQUABS)
    end)
end

return entity
