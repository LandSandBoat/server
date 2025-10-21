-- Acrolith family mixin
-- Customization:
--   Acrolith family of mobs have a behavior of losing body parts based on what skills
--   they perform. All acrolith type mobs can mix in this lua. This was sourced from
--   bg wiki which had the most detail: https://www.bg-wiki.com/ffxi/Category:Acrolith

require('scripts/globals/mixins')

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.acrolith = function(acrolithMob)
    acrolithMob:addListener('WEAPONSKILL_USE', 'ACROLITH_WEAPONSKILL_USE', function(mob, target, wsid, tp, action)
        if wsid == xi.mobSkill.DETONATING_GRIP then
            mob:setLocalVar('lost_r_arm', 1)
            return
        end

        if wsid == xi.mobSkill.DISMEMBERMENT then
            -- Dismemberment takes right arm first
            if mob:getLocalVar('lost_r_arm') == 0 then
                mob:setLocalVar('lost_r_arm', 1)
                return
            end
        end
    end)

    acrolithMob:addListener('WEAPONSKILL_STATE_EXIT', 'ACROLITH_WEAPONSKILL_STATE_EXIT', function(mob, skillID)
        if skillID == xi.mobSkill.DETONATING_GRIP then
            mob:setAnimationSub(5)
        end

        if skillID == xi.mobSkill.DISMEMBERMENT then            
            mob:setAnimationSub(5)
        end
    end)

    -- TODO find rate of fall apart crit event
    acrolithMob:addListener('CRITICAL_TAKE', 'ACROLITH_CRITICAL_TAKE', function(mob)
        local random = math.random(1, 100)

        if
            random <= 20 and
            mob:getLocalVar('lost_r_arm') == 1 and
            mob:getLocalVar('lost_body') == 0
        then
            -- Fall apart
            mob:setAnimationSub(6)
            mob:setAutoAttackEnabled(false)
            mob:setLocalVar('lost_r_arm', 1)
            mob:setLocalVar('lost_body', 1)            
        end
    end)
end

return g_mixins.families.acrolith
