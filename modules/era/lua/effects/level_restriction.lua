-----------------------------------
-- Module: Elemental Spirit Perpetuation Cost (level restriction)
-- Reverts perpetuation cost which is recalculated on level restriction if a summoned elemental spirit is present.
-- Source: https://forum.square-enix.com/ffxi/threads/22099-March-27-2012-%28JST%29-Version-Update
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_effect_level_restriction', xi.pre(xi.expansion.ABYSSEA))

m:addOverride('xi.effects.level_restriction.onEffectGain', function(target, effect)
    super(target, effect)
    xi.job_utils.summoner.applySpiritPerpetuationCost(target)
end)

m:addOverride('xi.effects.level_restriction.onEffectLose', function(target, effect)
    super(target, effect)
    xi.job_utils.summoner.applySpiritPerpetuationCost(target)
end)
