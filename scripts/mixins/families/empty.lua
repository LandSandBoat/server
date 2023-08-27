-----------------------------------
-- Empty mob ecosystem mixin
-----------------------------------
require("scripts/globals/mixins")
-----------------------------------

g_mixins = g_mixins or {}

local setModel = function(mob, skin)
    -- Strays in Vahzl can also spawn as Weeper and Seether models
    if
        mob:getZone():getID() == xi.zone.PROMYVION_VAHZL and
        mob:getName() == "Stray"
    then
        local chance = math.random(1, 10)
        if chance == 1 then -- Weeper
            mob:setLocalVar("strayType", 1)
            mob:setMobMod(xi.mobMod.SKILL_LIST, 256)
        elseif chance == 2 then -- Seether
            mob:setLocalVar("strayType", 2)
            mob:setMobMod(xi.mobMod.SKILL_LIST, 220)
        else -- Stray
            mob:setLocalVar("strayType", 3)
            mob:setMobMod(xi.mobMod.SKILL_LIST, 255)
        end
    end

    -- Two elements per model
    local model = 0
    if skin < 3 then
        model = 1
    elseif skin > 2 and skin < 5 then
        model = 2
    elseif skin > 4 and skin < 7 then
        model = 3
    elseif skin > 6 then
        model = 4
    end

    -- Set model depending on mob family
    if
        mob:getFamily() == 255 or
        (mob:getFamily() == 499 and
        mob:getLocalVar("strayType") == 3)
    then -- Wanderer/Stray
        if model == 4 then
            model = model + 1
        end

        mob:setModelId(1105 + model)
    elseif
        mob:getFamily() == 256 or
        (mob:getFamily() == 499 and
        mob:getLocalVar("strayType") == 1)
    then -- Weeper / Stray
        mob:setModelId(1111 + model)
    elseif
        mob:getFamily() == 220 or
        (mob:getFamily() == 499 and
        mob:getLocalVar("strayType") == 2)
    then -- Seether / Stray
        if model > 1 then
            model = model + 1
        end

        mob:setModelId(1116 + model)
    elseif mob:getFamily() == 241 then -- Thinker
        if model > 2 then
            model = model + 1
        end

        mob:setModelId(1122 + model)
    elseif mob:getFamily() == 137 or mob:getFamily() == 138 then -- Gorger
        mob:setModelId(1128 + model)
    elseif mob:getFamily() == 78 then -- Craver
        if model > 2 then
            model = model + 1
        end

        mob:setModelId(1133 + model)
    end
end

g_mixins.families.empty = function(emptyMob)
    emptyMob:addListener("SPAWN", "EMPTY_SPAWN", function(mob)
        -- Dark > Water > Lightning > Earth > Light > Fire > Ice > Wind
        local skin = math.random(1, 8)
        mob:setLocalVar("skin", skin)

        -- Set elemental resistances
        -- Currently bugged, mods cannot be set on spawn through a listener
        -- if skin == 1 then -- Dark
        --     mob:setMod(xi.mod.DARK_MEVA, 99)
        --     mob:setMod(xi.mod.SLEEPRES, 90)
        --     mob:setMod(xi.mod.LIGHT_MEVA, -27)
        -- elseif skin == 2 then -- Water
        --     mob:setMod(xi.mod.FIRE_MEVA, 80)
        --     mob:setMod(xi.mod.WATER_MEVA, 99)
        --     mob:setMod(xi.mod.POISONRES, 90)
        --     mob:setMod(xi.mod.THUNDER_MEVA, -27)
        -- elseif skin == 3 then -- Lightning
        --     mob:setMod(xi.mod.WATER_MEVA, 80)
        --     mob:setMod(xi.mod.POISONRES, 90)
        --     mob:setMod(xi.mod.THUNDER_MEVA, 99)
        --     mob:setMod(xi.mod.STUNRES, 90)
        --     mob:setMod(xi.mod.EARTH_MEVA, -27)
        -- elseif skin == 4 then -- Earth
        --     mob:setMod(xi.mod.THUNDER_MEVA, 80)
        --     mob:setMod(xi.mod.STUNRES, 90)
        --     mob:setMod(xi.mod.EARTH_MEVA, 99)
        --     mob:setMod(xi.mod.SLOWRES, 90)
        --     mob:setMod(xi.mod.WIND_MEVA, -27)
        -- elseif skin == 5 then -- Light
        --     mob:setMod(xi.mod.LIGHT_MEVA, 99)
        --     mob:setMod(xi.mod.LULLABYRES, 90)
        --     mob:setMod(xi.mod.DARK_MEVA, -27)
        -- elseif skin == 6 then -- Fire
        --     mob:setMod(xi.mod.ICE_MEVA, 80)
        --     mob:setMod(xi.mod.PARALYZERES, 90)
        --     mob:setMod(xi.mod.BINDRES, 90)
        --     mob:setMod(xi.mod.FIRE_MEVA, 99)
        --     mob:setMod(xi.mod.WATER_MEVA, -27)
        -- elseif skin == 7 then -- Ice
        --     mob:setMod(xi.mod.WIND_MEVA, 80)
        --     mob:setMod(xi.mod.GRAVITYRES, 90)
        --     mob:setMod(xi.mod.SILENCERES, 90)
        --     mob:setMod(xi.mod.ICE_MEVA, 99)
        --     mob:setMod(xi.mod.PARALYZERES, 90)
        --     mob:setMod(xi.mod.BINDRES, 90)
        --     mob:setMod(xi.mod.FIRE_MEVA, -27)
        -- else -- Wind
        --     mob:setMod(xi.mod.EARTH_MEVA, 80)
        --     mob:setMod(xi.mod.SLOWRES, 90)
        --     mob:setMod(xi.mod.WIND_MEVA, 99)
        --     mob:setMod(xi.mod.GRAVITYRES, 90)
        --     mob:setMod(xi.mod.SILENCERES, 90)
        --     mob:setMod(xi.mod.ICE_MEVA, -27)
        -- end

        setModel(mob, skin)
    end)

    emptyMob:addListener("ROAM_TICK", "EMPTY_ROAM_TICK", function(mob)
        local skin = mob:getLocalVar("skin")
        if skin % 2 == 0 and mob:getAnimationSub() ~= 2 then
            mob:setAnimationSub(2)
        elseif skin % 2 ~= 0 and mob:getAnimationSub() ~= 1 then
            mob:setAnimationSub(1)
        end

        -- TODO: Merge with Ghrah mixin
        -- Temporary solution until mods on spawn issue is corrected
        local buffed = mob:getLocalVar("buffed")
        if buffed == 0 then
            -- return EEM to neutral, overriding DB
            mob:setMod(xi.mod.FIRE_EEM, 100)
            mob:setMod(xi.mod.ICE_EEM, 100)
            mob:setMod(xi.mod.WIND_EEM, 100)
            mob:setMod(xi.mod.EARTH_EEM, 100)
            mob:setMod(xi.mod.THUNDER_EEM, 100)
            mob:setMod(xi.mod.WATER_EEM, 100)
            mob:setMod(xi.mod.LIGHT_EEM, 100)
            mob:setMod(xi.mod.DARK_EEM, 100)
        end

        if skin == 1 and buffed == 0 then -- Dark
            mob:setMod(xi.mod.DARK_EEM, 5)
            mob:setMod(xi.mod.LIGHT_EEM, 150)
            mob:setLocalVar("buffed", 1)
        elseif skin == 2 and buffed == 0 then -- Water
            mob:setMod(xi.mod.FIRE_EEM, 5)
            mob:setMod(xi.mod.WATER_EEM, 5)
            mob:setMod(xi.mod.THUNDER_EEM, 150)
            mob:setLocalVar("buffed", 1)
        elseif skin == 3 and buffed == 0 then -- Lightning
            mob:setMod(xi.mod.WATER_EEM, 5)
            mob:setMod(xi.mod.THUNDER_EEM, 5)
            mob:setMod(xi.mod.EARTH_EEM, 150)
            mob:setLocalVar("buffed", 1)
        elseif skin == 4 and buffed == 0 then -- Earth
            mob:setMod(xi.mod.THUNDER_EEM, 5)
            mob:setMod(xi.mod.EARTH_EEM, 5)
            mob:setMod(xi.mod.WIND_EEM, 150)
            mob:setLocalVar("buffed", 1)
        elseif skin == 5 and buffed == 0 then -- Light
            mob:setMod(xi.mod.LIGHT_EEM, 5)
            mob:setMod(xi.mod.DARK_EEM, 150)
            mob:setLocalVar("buffed", 1)
        elseif skin == 6 and buffed == 0 then -- Fire
            mob:setMod(xi.mod.ICE_EEM, 5)
            mob:setMod(xi.mod.FIRE_EEM, 5)
            mob:setMod(xi.mod.WATER_EEM, 150)
            mob:setLocalVar("buffed", 1)
        elseif skin == 7 and buffed == 0 then -- Ice
            mob:setMod(xi.mod.WIND_EEM, 5)
            mob:setMod(xi.mod.ICE_EEM, 5)
            mob:setMod(xi.mod.FIRE_EEM, 150)
            mob:setLocalVar("buffed", 1)
        elseif buffed == 0 then -- Wind
            mob:setMod(xi.mod.EARTH_EEM, 5)
            mob:setMod(xi.mod.WIND_EEM, 5)
            mob:setMod(xi.mod.ICE_EEM, 150)
            mob:setLocalVar("buffed", 1)
        end
    end)
end

return g_mixins.families.empty
