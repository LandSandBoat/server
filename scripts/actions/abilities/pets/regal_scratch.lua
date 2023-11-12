-----------------------------------
-- Regal Scratch
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onPetAbility = function(target, pet, skill, master, action)
    local params = {}
    params.str_wsc = 0.0 params.dex_wsc = 0.3 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.0 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.ele = xi.element.LIGHT
    local numhits = 3
    local accmod = -5
    local dmgmod = 3
    local dmgmodsubsequent = 1
    local totaldamage = 0

    local damage = xi.summon.avatarPhysicalMove(pet, target, skill, numhits, accmod, dmgmod, dmgmodsubsequent, xi.mobskills.physicalTpBonus.NO_EFFECT, 1, 2, 3, 0, params)
    totaldamage = xi.summon.avatarFinalAdjustments(damage.dmg, pet, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, numhits)

    target:takeDamage(totaldamage, pet, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    target:updateEnmityFromDamage(pet, totaldamage)

    return totaldamage
end

return abilityObject
