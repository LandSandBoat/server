require('scripts/globals/mixins')
-----------------------------------
xi = xi or {}
xi.mix = xi.mix or {}
xi.mix.ladybug = xi.mix.ladybug or {}

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

local function night(mob)
    if mob:getLocalVar('Phase') == 0 then
        mob:setMobMod(xi.mobMod.NO_AGGRO, 1)
        mob:setMobMod(xi.mobMod.ROAM_COOL, 10)
        mob:delMod(xi.mod.EVA, 15)
        mob:delMod(xi.mod.ACC, 15)
        mob:setMod(xi.mod.DELAY, -400)
        mob:setMobMod(xi.mobMod.SKILL_LIST, mob:getLocalVar('[ladybug]nightSkillList'))
        mob:setLocalVar('Phase', 1)
    end
end

local function day(mob)
    if mob:getLocalVar('Phase') == 1 then
        mob:setMobMod(xi.mobMod.NO_AGGRO, 0)
        mob:setMobMod(xi.mobMod.ROAM_COOL, 0)
        mob:addMod(xi.mod.EVA, 15)
        mob:addMod(xi.mod.ACC, 15)
        mob:setMod(xi.mod.DELAY, 0)
        mob:setMobMod(xi.mobMod.SKILL_LIST, mob:getLocalVar('[ladybug]daySkillList'))
        mob:setLocalVar('Phase', 0)
    end
end

xi.mix.ladybug.config = function(mob, params)
    if params.nightTime and type(params.nightTime) == 'number' then
        mob:setLocalVar('[ladybug]nightTime', params.nightTime)
    end

    if params.morning and type(params.morning) == 'number' then
        mob:setLocalVar('[ladybug]morning', params.morning)
    end
end

g_mixins.families.ladybug = function(mob)
    mob:addListener('SPAWN', 'LADYBUG_SPAWN', function(ladybug)
        ladybug:setLocalVar('[ladybug]daySkillList', 170)
        ladybug:setLocalVar('[ladybug]nightSkillList', 1173)
    end)

    mob:addListener('ROAM_TICK', 'LADYBUG_ROAM_TICK', function(ladybug)
        local currentHour = VanadielHour()

        if currentHour >= 18 or currentHour < 6 then
            night(ladybug)
        elseif currentHour < 18 and currentHour >= 6 then
            day(ladybug)
        end
    end)

    mob:addListener('COMBAT_TICK', 'LADYBUG_COMBAT_TICK', function(ladybug)
        local currentHour = VanadielHour()

        if currentHour >= 18 or currentHour < 6 then
            night(ladybug)
        elseif currentHour < 18 and currentHour >= 6 then
            day(ladybug)
        end
    end)
end

return g_mixins.families.ladybug
