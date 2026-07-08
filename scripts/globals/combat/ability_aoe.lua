-----------------------------------
-- Global file for ability AoE type and radius calculations.
-----------------------------------
xi = xi or {}
xi.combat = xi.combat or {}
xi.combat.abilityAoE = xi.combat.abilityAoE or {}

---Calculate ability AoE type and radius based on caster modifiers.
---@param caster CBaseEntity
---@param ability CAbility
---@return [xi.aoeType, number]
xi.combat.abilityAoE.calculateTypeAndRadius = function(caster, ability)
    local baseType   = ability:getAOE()
    local baseRadius = ability:getRadius()
    local recastId   = ability:getRecastID()

    -- Epeolatry makes Liement a 10y AoE
    if
        ability:getID() == xi.jobAbility.LIEMENT and
        caster:getMod(xi.mod.LIEMENT_EXTENDS_TO_AREA) > 0
    then
        return { xi.aoeType.ROUND, 10 }
    end

    -- Contradance makes Healing Waltz a 10y AoE
    if
        ability:getID() == xi.jobAbility.HEALING_WALTZ and
        caster:hasStatusEffect(xi.effect.CONTRADANCE)
    then
        return { xi.aoeType.ROUND, 10 }
    end

    -- Luzaf's Ring increases COR roll radius (8y -> 16y)
    if
        recastId == xi.recastID.PHANTOM_ROLL or
        recastId == xi.recastID.DOUBLE_UP
    then
        return { xi.aoeType.ROUND, baseRadius + caster:getMod(xi.mod.ROLL_RANGE) }
    end

    return { baseType, baseRadius }
end
