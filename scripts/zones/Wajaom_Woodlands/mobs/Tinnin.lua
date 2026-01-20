-----------------------------------
-- Area: Wajaom Woodlands
--  ZNM: Tinnin
-- !pos 276 0 -694
-- Spawned with Monkey Wine: @additem 2573
-----------------------------------
mixins =
{
    require('scripts/mixins/job_special'),
    require('scripts/mixins/rage')
}
-----------------------------------
---@type TMobEntity
local entity = {}

local function regenerateHead(mob, animationSub)
    -- Reset timer.
    mob:setLocalVar('headTimer', GetSystemTime() + math.random(90, 210))

    -- Set animationSub.
    mob:setAnimationSub(animationSub - 1)

    -- Handle health regeneration.
    local multiplier = 0.05

    -- 2 heads to 3 heads.
    if animationSub == 1 then
        if mob:getLocalVar('head3Regeneration') == 0 then
            mob:setLocalVar('head3Regeneration', 1)
            multiplier = 0.25

            mob:setMod(xi.mod.REGEN, 10) -- Lower regeneration.
            mob:setUnkillable(false)     -- Allow death.
        end

    -- 1 head to 2 heads.
    elseif animationSub == 2 then
        if mob:getLocalVar('head2Regeneration') == 0 then
            mob:setLocalVar('head2Regeneration', 1)
            multiplier = 0.25
        end
    end

    mob:addHP(mob:getMaxHP() * multiplier)
end

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.GIL_MIN, 12000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 30000)
    mob:setMobMod(xi.mobMod.MUG_GIL, 8000)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

entity.onMobSpawn = function(mob)
    mob:setHP(mob:getMaxHP() / 2)
    mob:setUnkillable(true)

    mob:setMod(xi.mod.REGEN, 50)
    mob:setMod(xi.mod.UDMGBREATH, -10000) -- Immune to breath damage

    mob:setLocalVar('[rage]timer', 3600) -- 60 minutes

    mob:setLocalVar('headTimer', GetSystemTime() + math.random(90, 210))
    mob:setLocalVar('head2Regeneration', 0)
    mob:setLocalVar('head3Regeneration', 0)

    -- Number of crits to lose a head
    mob:setLocalVar('criticalsThreshold', math.random(10, 30))
    mob:setLocalVar('criticalsTaken', 0)
end

entity.onMobRoam = function(mob)
    -- Regen head logic.
    local animationSub = mob:getAnimationSub()
    if animationSub == 0 then
        return
    end

    if GetSystemTime() < mob:getLocalVar('headTimer') then
        return
    end

    regenerateHead(mob, animationSub)
end

entity.onMobFight = function(mob, target)
    local drawInTable =
    {
        conditions =
        {
            mob:checkDistance(target) >= mob:getMeleeRange(target) * 2,
        },
        position = mob:getPos(),
    }

    if drawInTable.conditions[1] then
        if utils.drawIn(target, drawInTable) then
            mob:addTP(3000) -- Uses a mobskill upon drawing in a player. Not necessarily on the person drawn in.
        end
    end

    -- Regen head logic.
    local animationSub = mob:getAnimationSub()
    if animationSub == 0 then
        return -- No heads to regen.
    end

    if GetSystemTime() < mob:getLocalVar('headTimer') then
        return -- Can't regen head yet.
    end

    regenerateHead(mob, animationSub)

    -- Mobskill chain logic.
    if bit.band(mob:getBehavior(), xi.behavior.NO_TURN) > 0 then -- disable no turning for the forced mobskills upon head growth
        mob:setBehavior(bit.band(mob:getBehavior(), bit.bnot(xi.behavior.NO_TURN)))
    end

    -- Reverse order, same deal.
    mob:useMobAbility(xi.mobSkill.BAROFIELD)
end

entity.onMobWeaponSkill = function(target, mob, skill)
    local skillId = skill:getID()

    -- Barofield -> Polar Blast -> Pyric Blast chain.
    if skillId == xi.mobSkill.BAROFIELD then
        mob:useMobAbility(xi.mobSkill.POLAR_BLAST)
    elseif skillId == xi.mobSkill.POLAR_BLAST then
        if mob:getAnimationSub() == 0 then
            mob:useMobAbility(xi.mobSkill.PYRIC_BLAST)
        end

    -- Pyric/Polar Bulwark -> Nerve Gas
    elseif skillId == xi.mobSkill.PYRIC_BULWARK then
        mob:useMobAbility(xi.mobSkill.NERVE_GAS)
    elseif skillId == xi.mobSkill.POLAR_BULWARK then
        mob:useMobAbility(xi.mobSkill.NERVE_GAS)
    end
end

entity.onCriticalHit = function(mob)
    local animationSub = mob:getAnimationSub()
    if animationSub == 2 then
        return -- No heads to loose.
    end

    local criticalCounter = mob:getLocalVar('criticalsTaken') + 1
    if criticalCounter >= mob:getLocalVar('criticalsThreshold') then
        criticalCounter = 0 -- Reset critical count.
        mob:setAnimationSub(animationSub + 1)
        mob:setLocalVar('headTimer', GetSystemTime() + math.random(90, 210))
        mob:setLocalVar('criticalsThreshold', math.random(10, 30)) -- Reset critical threshold.
    end

    mob:setLocalVar('criticalsTaken', criticalCounter)
end

return entity
