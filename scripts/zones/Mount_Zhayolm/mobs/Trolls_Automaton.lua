-----------------------------------
-- Area: Mount Zhayolm
--  Mob: Troll's Automaton
-----------------------------------
mixins = { require('scripts/mixins/families/Troll_Automaton') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobMobskillChoose = function(mob, target, skillId)
    return xi.mix.trollAutomaton.onMobMobskillChoose(mob, target)
end

return entity
