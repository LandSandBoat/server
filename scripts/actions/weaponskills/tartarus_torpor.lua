-----------------------------------
-- Tartarus Torpor
-- Staff weapon skill
-- Skill Level: N/A
-- Puts to sleep enemies within the area of effect and lowers their magical defense and magical evasion. Duration of effect varies with TP.
-- Available while Samudra is equipped during Campaign battles.
-- Deals no damage. All three effects land or miss together and share the same duration.
-- Element: Dark
-- 100%TP    200%TP    300%TP
-- 20s       30s       40s
-----------------------------------
---@type TWeaponSkill
local weaponskillObject = {}

local effects =
{
    { id = xi.effect.SLEEP_I,            power = 1 },
    { id = xi.effect.MAGIC_DEF_DOWN,     power = 5 }, -- TODO: Capture me
    { id = xi.effect.MAGIC_EVASION_DOWN, power = 5 }, -- TODO: Capture me
}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local resist = applyResistanceAddEffect(player, target, xi.element.DARK, 0)
    if resist < 0.5 then
        action:resolution(target:getID(), xi.action.resolution.MISS)
        action:messageID(target:getID(), xi.msg.basic.SKILL_MISS)
        return 0, 0, false, 0
    end

    local duration = math.floor((10 + tp / 100) * resist) -- DAT, FFO says 20, 40, 60
    local landed   = nil
    for _, effect in ipairs(effects) do
        if
            not target:hasStatusEffect(effect.id) and
            not xi.data.statusEffect.isTargetImmune(target, effect.id, xi.element.DARK) and
            not xi.data.statusEffect.isTargetResistant(player, target, effect.id) and
            not xi.data.statusEffect.isEffectNullified(target, effect.id, 0)
        then
            target:addStatusEffect(effect.id, { power = effect.power, duration = duration, origin = player })
            landed = landed or effect.id
        end
    end

    if landed then
        action:messageID(target:getID(), xi.msg.basic.SKILL_ENFEEB_IS)
        action:param(target:getID(), landed)
    else
        action:messageID(target:getID(), xi.msg.basic.SKILL_NO_EFFECT)
    end

    return 1, 0, false, 0
end

return weaponskillObject
