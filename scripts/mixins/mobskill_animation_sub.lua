-- Mixin to handle Animation Sub updates for mob skill completions

require('scripts/globals/mixins')

g_mixins = g_mixins or {}

g_mixins.mobskillAnimationSub = function(mobObject)
    -- SELECT CONCAT("[",mob_skill_id,"] = X, -- ",mob_skill_name) FROM mob_skills WHERE mob_skill_name IN ("axe_throw"...
    local mobskillAnimationSubs =
    {
        [310]  = 1, -- queasyshroom
        [311]  = 2, -- numbshroom
        [312]  = 3, -- shakeshroom
        [954]  = 2, -- touchdown
        [1282] = 2, -- touchdown
        [1292] = 2, -- touchdown
        [1302] = 2, -- touchdown
    }

    -- creates a listener to set the mob's animation sub after the skill completes
    -- Only changes the animation sub if the move completed successfully
    local localVarName = 'MOBSKILL_LANDED'
    mobObject:addListener('WEAPONSKILL_STATE_EXIT', 'MOBSKILL_ANIMATION_SUB_WS_EXIT', function(mob, skillID)
        local newAnimationSub = mobskillAnimationSubs[skillID]
        if
            newAnimationSub and
            mob:getLocalVar(localVarName) == 1 and
            mob:getAnimationSub() ~= newAnimationSub
        then
            mob:setAnimationSub(newAnimationSub)
        end

        mob:setLocalVar(localVarName, 0)
    end)

    -- creates a listener to indicate that the mobskill completed on a target
    -- this listener is not called if a move readies but doesn't complete
    mobObject:addListener('WEAPONSKILL_USE', 'MOBSKILL_ANIMATION_SUB_WS_LANDED', function(mob)
        mob:setLocalVar(localVarName, 1)
    end)
end

return g_mixins.mobskillAnimationSub
