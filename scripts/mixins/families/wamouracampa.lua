-- Wamouracampa family mixin

require("scripts/globals/mixins")
require("scripts/globals/status")
-----------------------------------
g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

local function curlUpRoaming(mob)
    mob:setAnimationSub(5) -- Curl
    mob:setLocalVar("formTimeRoam", os.time() + math.random(43, 47))
    mob:setMobMod(xi.mobMod.SKILL_LIST, 1162) -- Set Curled Skill List. ("Cannonball" and "Heat Barrier" only)
    -- TODO: Change resistances.
end

local function strechUpRoaming(mob)
    mob:setAnimationSub(4) -- Strech
    mob:setLocalVar("formTimeRoam", os.time() + math.random(43, 47))
    mob:setMobMod(xi.mobMod.SKILL_LIST, 254) -- Set streched Skill List. (All TP moves except "Cannonball")
    -- TODO: Change resistances.
end

local function curlUpEngaged(mob)
    mob:setAnimationSub(5) -- Curl
    mob:setMobMod(xi.mobMod.SKILL_LIST, 1162) -- Set Curled Skill List
end

local function strechUpEngaged(mob)
    mob:setAnimationSub(4) -- Strech
    mob:setMobMod(xi.mobMod.SKILL_LIST, 254) -- Set streched Skill List. (Cannonball and Heat Barrier ONLY)
end

local function resetCount(mob)
    mob:setLocalVar("formTimeEngaged", os.time() + math.random(40, 50))
    mob:setLocalVar("hitPoints",  mob:getHP() - math.floor(mob:getMaxHP() * 20 / 100))
end

g_mixins.families.wamouracampa = function(wamouracampaMob)
    wamouracampaMob:addListener("SPAWN", "WAMOURACAMPA_SPAWN", function(mob)
        mob:setAnimationSub(4)
        mob:setLocalVar("hitPoints", mob:getHP())
        mob:setLocalVar("formTimeRoam", os.time() + math.random(10, 60))
        mob:setLocalVar("formTimeEngaged", os.time())
        -- mob:setLocalVar("morphTime", os.time() + math.random(300, 600))
    end)

    wamouracampaMob:addListener("ROAM_TICK", "WAMOURACAMPA_ROAM", function(mob)
        if os.time() - mob:getLocalVar("formTimeRoam") > 0 then
            if mob:getAnimationSub() == 4 then
                curlUpRoaming(mob)
            elseif mob:getAnimationSub() == 5 then
                strechUpRoaming(mob)
            end
        end
    end)

    -- First damaging hit makes mob curl if not already.
    wamouracampaMob:addListener("ENGAGE", "WAMOURACAMPA_ENGAGE", function(mob)
        if
            mob:getLocalVar("hitPoints") < mob:getHP() and
            mob:getAnimationSub() == 4
        then
            curlUpEngaged(mob)
            resetCount(mob)
        end
    end)

    -- Handle streching from curl.
    wamouracampaMob:addListener("COMBAT_TICK", "WAMOURACAMPA_COMBAT", function(mob)
        -- This mobs curl up based on damage taken.
        -- If they take a hit higher than 5% oh their Max HP OR if they take a total of 1k (aprox) damage, they will curl.
        -- If they are already curled, they will reset conditions and remain curled.
        -- They will keep streched so long as none of the above conditions are met. Linked Wamouracampas will obviously stay streched.
        if
            mob:getAnimationSub() == 5 and
            os.time() - mob:getLocalVar("formTimeEngaged") > 0 and -- IF safety timer is over
            os.time() - mob:getLocalVar("formTimeRoam") > 0 and    -- Additional check in case its already curled.
            mob:getLocalVar("hitPoints") < mob:getHP()
        then
            strechUpEngaged(mob)
            resetCount(mob)
        end
    end)

    -- Handle curling from being streched or remaining curled.
    wamouracampaMob:addListener("TAKE_DAMAGE", "WAMOURACAMPA_TAKE_DAMAGE", function(mob, amount, attacker, attackType, damageType)
        if
            os.time() - mob:getLocalVar("formTimeEngaged") > 0 and
            (amount > math.floor(mob:getMaxHP() * 5 / 100) or
            mob:getLocalVar("hitPoints") > mob:getHP())
        then
            if mob:getAnimationSub() == 4 then
                curlUpEngaged(mob)
            end

            resetCount(mob)
        end
    end)
end

return g_mixins.families.wamouracampa
