-----------------------------------
-- Area: Horlais Peak
--  Mob: Evil Oscar
-- KSNM30
--
-- DONE: If you are out of range of EBB, the move will be lost
-- TODO: There should be a "No targets within range" message
--
-- ['Evil Oscar-17346750'] =
-- {
--     [4] =
--     {
--         -- NOTE: This looks to be the no target message
--         [0]    = { ['name']="",                     ['category']=4,  ['id']=0,    ['animation']=508,  ['message']=76,  },
--     },
--
--     [11] =
--     {
--         [317]  = { ['name']="Vampiric Lash",        ['category']=11, ['id']=317,  ['animation']=61,   ['message']=31,  },
--         [320]  = { ['name']="Sweet Breath",         ['category']=11, ['id']=320,  ['animation']=64,   ['message']=185, },
--         [1332] = { ['name']="Extremely Bad Breath", ['category']=11, ['id']=1332, ['animation']=63,   ['message']=406, },
--     },
-- },
-----------------------------------
local ID = require("scripts/zones/Horlais_Peak/IDs")
-----------------------------------
local entity = {}

local extremelyBadBreathID = 1332

local sendMessage = function(players)
    for _, member in pairs(players) do
        member:messageSpecial(ID.text.EVIL_OSCAR_BEGINS_FILLING)
    end
end

local evilOscarFillsHisLungs
evilOscarFillsHisLungs = function(mob)
    if not mob:isAlive() then
        return
    end

    local battlefield = mob:getBattlefield()
    local players = battlefield:getPlayers()

    local someoneIsAlive = false
    for _, member in pairs(players) do
        if member:isAlive() then
            someoneIsAlive = true
        end
    end

    if someoneIsAlive then
        local ebbBreathCounter = mob:getLocalVar("EBB_BREATH_COUNTER")
        if ebbBreathCounter < 2 then -- Charge two breaths
            sendMessage(players)
            mob:setLocalVar("EBB_BREATH_COUNTER", ebbBreathCounter + 1)
        else -- On the third breath, fire straight away!
            sendMessage(players)
            mob:setLocalVar("EBB_BREATH_COUNTER", 0)
            mob:useMobAbility(extremelyBadBreathID)
        end

        -- Every 10-20 seconds
        mob:timer(math.random(10000, 20000), evilOscarFillsHisLungs)
    end
end

entity.onMobInitialize = function(mob)
    -- Melee attacks have Additional effect: Weight.
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.WEIGHT)
end

entity.onMobSpawn = function(mob)
end

entity.onMobEngaged = function(mob, target)
    -- Start breaths rotation after 10-20 seconds
    mob:timer(math.random(10000, 20000), evilOscarFillsHisLungs)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
