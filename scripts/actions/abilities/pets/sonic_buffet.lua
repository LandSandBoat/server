-----------------------------------
-- Sonic Buffet
-- Family: Siren (Player Pet)
-----------------------------------
---@type TAbilityPet
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

-- http://wiki.ffo.jp/html/37931.html
abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    local params = {}

    params.baseDamage      = pet:getMainLvl() + 2
    -- TODO: upon smn BP damage rewrite, the base damage & mods etc need to be re-evaluated.
    -- fTP starts at 2.0 and scales every 150 tp by .1 for a range of 2.0 to 4.0. Base value ballparked from retail.
    params.fTP             = { 2.0, 3.0, 4.0 }
    params.int_wSC         = 0.30
    params.element         = xi.element.WIND
    params.attackType      = xi.attackType.MAGICAL
    params.damageType      = xi.damageType.WIND
    params.shadowBehavior  = xi.mobskills.shadowBehavior.NUMSHADOWS_1 -- TODO: Capture shadowBehavior
    params.dStatMultiplier = 1.5
    params.canMagicBurst   = true
    params.primaryMessage  = xi.msg.basic.USES_JA_TAKE_DAMAGE

    local info = xi.mobskills.mobMagicalMove(pet, target, petskill, action, params)

    if xi.mobskills.processDamage(pet, target, petskill, action, info) then
        target:takeDamage(info.damage, pet, info.attackType, info.damageType)
    end

    -- Note: This dispel is Wind based rather than Dark.
    local maccParams =
    {
        effectId       = xi.effect.NONE,
        magicalElement = xi.element.WIND,
        bonusMacc      = xi.summon.getSummoningSkillOverCap(pet),
        actorStat      = xi.mod.INT,
    }

    local resist = xi.combat.magicHitRate.calculateResistRate(pet, target, maccParams)
    if resist >= 0.5 then
        target:dispelStatusEffect()
    end

    pet:setTP(0) -- Not possible to get Occult Acumen on avatars yet, so unable to determine if magical BPs can return TP.

    return info.damage
end

return abilityObject
