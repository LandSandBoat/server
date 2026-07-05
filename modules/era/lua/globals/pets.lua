-----------------------------------
-- Module: Elemental Spirit Perpetuation Cost
-- Reverts perpetuation cost which is calculated on pet spawn and set with a AVATAR_PERPETUATION mod on the player.
-- Source: https://forum.square-enix.com/ffxi/threads/22099-March-27-2012-%28JST%29-Version-Update
-----------------------------------
require('modules/module_utils')
-----------------------------------
local moduleName = 'era_globals_pets'

if xi.module.isContentEnabled('ABYSSEA') then
    return { name = moduleName }
end

local m = Module:new(moduleName)

m:addOverride('xi.pet.spawnPet', function(caster, petID, state, target)
    super(caster, petID, state, target)

    xi.job_utils.summoner.applySpiritPerpetuationCost(caster)
end)

return m
