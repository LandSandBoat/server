require("scripts/globals/mixins")
require("scripts/globals/status")
-----------------------------------

xi = xi or {}
xi.mix = xi.mix or {}
xi.mix.ladybug = xi.mix.ladybug or {}

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

local function night(mob)
    if mob:getLocalVar("Phase") == 0 then
        mob:setMobMod(xi.mobMod.NO_AGGRO, 1)
        mob:setMobMod(xi.mobMod.ROAM_COOL, 10)
        mob:delMod(xi.mod.TRIPLE_ATTACK, 20)
        mob:delMod(xi.mod.EVA, 15)
        mob:delMod(xi.mod.ACC, 15)
        mob:setMobMod(xi.mobMod.SKILL_LIST, mob:getLocalVar("[ladybug]nightSkillList"))
        mob:setLocalVar("Phase", 1)
    end
end

local function day(mob)
    if mob:getLocalVar("Phase") == 1 then
        mob:setMobMod(xi.mobMod.NO_AGGRO, 0)
        mob:setMobMod(xi.mobMod.ROAM_COOL, 0)
        mob:addMod(xi.mod.TRIPLE_ATTACK, 20)
        mob:addMod(xi.mod.EVA, 15)
        mob:addMod(xi.mod.ACC, 15)
        mob:setMobMod(xi.mobMod.SKILL_LIST, mob:getLocalVar("[ladybug]daySkillList"))
        mob:setLocalVar("Phase", 0)
    end
end

xi.mix.ladybug.config = function(mob, params)
    if params.nightTime and type(params.nightTime) == "number" then
        mob:setLocalVar("[ladybug]nightTime", params.nightTime)
    end
    if params.morning and type(params.morning) == "number" then
        mob:setLocalVar("[ladybug]morning", params.morning)
    end
end

g_mixins.families.ladybug = function(mob)
    mob:addListener("SPAWN", "LADYBUG_SPAWN", function(mob)
        mob:setLocalVar("[ladybug]nightTime", 18)
        mob:setLocalVar("[ladybug]morning", 6)
        mob:setLocalVar("[ladybug]daySkillList", 170)
        mob:setLocalVar("[ladybug]nightSkillList", 1167)
    end)

    mob:addListener("ROAM_TICK", "LADYBUG_ROAM_TICK", function(mob)
        local currentHour = VanadielHour()
        local nightTime = mob:getLocalVar("[ladybug]nightTime")
        local morning = mob:getLocalVar("[ladybug]morning")

        if currentHour >= nightTime or currentHour < morning then
            night(mob)
        elseif currentHour < nightTime and currentHour >= morning then
            day(mob)
        end
    end)

    mob:addListener("COMBAT_TICK", "LADYBUG_COMBAT_TICK", function(mob)
        local currentHour = VanadielHour()
        local nightTime = mob:getLocalVar("[ladybug]nightTime")
        local morning = mob:getLocalVar("[ladybug]morning")

        if currentHour >= nightTime or currentHour < morning then
            night(mob)
        elseif currentHour < nightTime and currentHour >= morning then
            day(mob)
        end
    end)
end

return g_mixins.families.ladybug
