-----------------------------------
-- Area: Arrapago Reef
--   NM: Bukki
-----------------------------------
mixins =
{
    require('scripts/mixins/job_special'),
    require('scripts/mixins/families/imp'),
}
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.mobSkill.MANAFONT_1, hpp = math.randomInt(10, 50) },
        },
    })

    mob:setTP(3000)
    mob:setMobSkillAttack(0)
    mob:setMagicCastingEnabled(true)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
    mob:setMobMod(xi.mobMod.GIL_MAX, -1)
    mob:setLocalVar('tp_spam', math.randomInt(5, 15))
    mob:addListener('COMBAT_TICK', 'BUKKI_TICK', function(mobArg)
        if
            mobArg:getHPP() <= mobArg:getLocalVar('tp_spam') and
            mobArg:getLocalVar('tp_spam') > 0
        then
            mobArg:setLocalVar('tp_spam', 0)
            mobArg:setMagicCastingEnabled(false)
            mobArg:setMobSkillAttack(788)
        end
    end)
end

return entity
