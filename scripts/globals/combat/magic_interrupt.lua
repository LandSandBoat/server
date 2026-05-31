-----------------------------------
-- Global file for spell interrupt
-----------------------------------
xi = xi or {}
xi.combat = xi.combat or {}
xi.combat.magic = xi.combat.magic or {}

---Return whether a spell should be interrupted.
---@params attacker CBaseEntity
---@params defender CBaseEntity
---@params spell CSpell
---@return boolean
xi.combat.magic.shouldInterruptSpell = function(attacker, defender, spell)
    -- Exceptions.
    if
        defender:getObjType() == xi.objType.TRUST or    -- Caster is a trust.
        defender:hasStatusEffect(xi.effect.MANAFONT) or -- Caster has Manafont
        spell:getSkillType() == xi.skill.SINGING        -- Spell is a song.
    then
        return false
    end

    -- Calculate level ratio. BaseRate + Attacker main level - Defender main level.
    local levelRatio = ((defender:getObjType() == xi.objType.MOB and 5 or 50) + attacker:getMainLvl() - defender:getMainLvl()) / 100.0

    if levelRatio < 0.01 then
        levelRatio = 0.01
    end

    -- Calculate skill ratio.
    local skillRatio = 1.0
    local meritReduction = 0

    if defender:getObjType() == xi.objType.PC then
        local skillType = spell:getSkillType()
        local skillCap  = defender:getMaxSkillLevel(defender:getMainLvl(), defender:getMainJob(), skillType)
        local skillLevel     = defender:getSkillLevel(skillType)

        -- If skill cap is 0, player may be using a spell from their subjob.
        if skillCap == 0 then
            skillCap = defender:getMaxSkillLevel(defender:getMainLvl(), defender:getSubJob(), skillType)
        end

        -- If skill level is 0, set ratio to 10.
        if skillLevel <= 0 then
            skillRatio = 10.0
        else
            skillRatio = skillCap / skillLevel
        end

        -- Fetch player-only interruption rate reduction from merits.
        meritReduction = defender:getMerit(xi.merit.SPELL_INTERUPTION_RATE)
    end

    -- SIRD reduces the interrupt after all the calculations are done -- as evidenced by the infamous "102% SIRD" builds.
    -- Anything less than 102% interrupt results in the ability to be interrupted.
    -- Note: the 102% is probably an x/256 x/1024 nonsense -- sometimes 101% works.
    local sirdRatio  = (100.0 - meritReduction - defender:getMod(xi.mod.SPELLINTERRUPT)) / 100.0
    local chance     = math.random()

    -- These are all ratios.
    -- levelRatio : 0.01 to infinity.
    -- skillRatio:  1.0 to infinity.
    -- SIRDRatio:   No limits. Can be negative. A negative value will guarantee NOT being interrupted.
    local finalRatio = levelRatio * skillRatio * sirdRatio -- TL;DR Higher = Worse = More chances to get interrupted.

    -- You get interrupted. Handle aquaveil.
    if chance < finalRatio then
        if defender:hasStatusEffect(xi.effect.AQUAVEIL) then
            local aquaCount = defender:getStatusEffect(xi.effect.AQUAVEIL):getPower()

            -- Removes the status but still prevents the interrupt.
            if aquaCount - 1 == 0 then
                defender:delStatusEffect(xi.effect.AQUAVEIL)
            else
                defender:getStatusEffect(xi.effect.AQUAVEIL):setPower(aquaCount - 1)
            end

            return false
        end

        return true
    end

    return false
end
