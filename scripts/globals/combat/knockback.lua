-----------------------------------
-- Global, independent functions for knockback calculations.
-----------------------------------
xi = xi or {}
xi.combat = xi.combat or {}
xi.combat.knockback = xi.combat.knockback or {}
-----------------------------------

---@param target CBaseEntity
---@param attacker CBaseEntity
---@param skillOrSpell CMobSkill | CSpell
---@param action CAction
---@return xi.action.knockback
xi.combat.knockback.calculate = function(target, attacker, skillOrSpell, action)
    return utils.clamp(skillOrSpell:getKnockback() - target:getMod(xi.mod.KNOCKBACK_REDUCTION), xi.action.knockback.NONE, xi.action.knockback.LEVEL7)
end
