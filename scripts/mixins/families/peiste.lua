-- Peiste family mixin
-- Gaze-Aura effects: certain skills will cause the mob to have glowy eyes, which then afflicts effects in a gaze during the duration of the glowy eyes
--     Blind will short-circuit the gaze animation and effects

require('scripts/globals/mixins')

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

-- Maps mobskill IDs to animation sub
local gazeAnimationSubs =
{
    [2156] = 1, -- Grim Glower
    [2392] = 5, -- Oppressive Glare
}

-- Maps animation sub to gaze-aura effects
-- Will default to power = 1 and duration = 15
local gazeEffects =
{
    -- red eyes
    [1] =
    {
        [xi.effect.PETRIFICATION] =
        {
            duration = 15,
        },
    },

    -- Orange eyes
    -- TODO verify this data for Oppressive Glare when skill is coded
    [5] =
    {
        [xi.effect.CURSE_II] =
        {
            power = 0,
            duration = 30,
        },
        [xi.effect.TERROR] =
        {
            duration = 30,
        },
    },
}

g_mixins.families.peiste = function(peisteMob)
    peisteMob:addListener('WEAPONSKILL_USE', 'PEISTE_MIXIN_WS_USE', function(mob, target, skillID)
        local gazeAnimSub = gazeAnimationSubs[skillID]
        if gazeAnimSub and not mob:getStatusEffect(xi.effect.BLINDNESS) then
            -- Sets glowy eyes, which triggers the combat tick aura gaze
            mob:setAnimationSub(gazeAnimSub)
            mob:timer(math.random(30, 45) * 1000, function(mobArg)
                mobArg:setAnimationSub(0)
            end)
        end
    end)

    peisteMob:addListener('COMBAT_TICK', 'PEISTE_MIXIN_CTICK', function(mob, target)
        local gazeData = gazeEffects[mob:getAnimationSub()]
        if gazeData then
            if mob:getStatusEffect(xi.effect.BLINDNESS) then
                -- Note that testing this manually will break the animation for the game client
                -- (i.e. setAnimationSub(1) with blindness up will correctly remove the animation sub immediately, but the game won't get updated)
                mob:setAnimationSub(0)
            else
                for _, entityObj in pairs(mob:getEnmityList()) do
                    local entity = entityObj['entity']
                    -- TODO verify exact range of gaze
                    if mob:checkDistance(entity) < 10 then
                        for gazeEffect, gazeEffectInfo in pairs(gazeData) do
                            if not entity:getStatusEffect(gazeEffect) then
                                local power = gazeEffectInfo.power or 1
                                local duration = gazeEffectInfo.duration or 15
                                xi.mobskills.mobGazeMove(mob, entity, gazeEffect, power, 3, duration)
                            end
                        end
                    end
                end
            end
        end
    end)
end

return g_mixins.families.peiste
