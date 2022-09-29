-----------------------------------
-- Area: Escha - Ru'Aun
-- NM: Suzaku
-- TODO: Make flamingos immune to sleep/bind/gravity
-----------------------------------
local ID = require("scripts/zones/Escha_RuAun/IDs")
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/mobs")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob, target)
    mob:setDropID(3992)
end

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobFight = function(mob, target, spellId) -- This function is fired every 400 ms.
    local currentTime = os.time()

    -- Pet logic here
    local spawnTime = 20 -- Spawn dynamic entity every interval of seconds
    local nextPet   = mob:getLocalVar("nextPetPop")

    if nextPet == 0 then
        nextPet = currentTime + spawnTime
        mob:setLocalVar("nextPetPop", nextPet)
    end

    -- 2-Hour Logic
    local twoHourTime  = mob:getLocalVar("twoHourTime")
    local fifteenBlock = mob:getBattleTime() / 15

    -- Randomize opportunity to use blood weapon (2-hour skill)
    if twoHourTime == 0 then
        twoHourTime = math.random(4, 6)
        mob:setLocalVar("twoHourTime", twoHourTime)
    end

    -- DEBUG
    -- print(string.format("spawnTime: %s fifteenBlock: %s", spawnTime, fifteenBlock))
    
    -- check to see if we can use blood weapon
    if fifteenBlock > twoHourTime then
        mob:useMobAbility(695) -- blood weapon
        mob:setLocalVar("twoHourTime", fifteenBlock + math.random(4, 6))
    end
    
    if currentTime > nextPet then
        -- Variable Work for next pet cooldown.
        nextPet = currentTime + spawnTime
        mob:setLocalVar("nextPetPop", nextPet)

        -- Get random player from the enmity list to attach an add to
        local enmityList   = mob:getEnmityList()
        local numEntries   = #enmityList
        local randomPlayer = utils.randomEntry(enmityList)["entity"]
        local zone         = randomPlayer:getZone()

        -- Dynamic Entity Definition
        local mob    = zone:insertDynamicEntity({
            objtype  = xi.objType.MOB,
            name     = "Suzaku's Minion",
            x        = randomPlayer:getXPos(),
            y        = randomPlayer:getYPos(),
            z        = randomPlayer:getZPos(),
            rotation = randomPlayer:getRotPos(),
        
            -- Flamingo
            groupId     = 2,
            groupZoneId = 130,

            onMobDeath = function(mob, playerArg, isKiller)
                -- mob:setLocalVar("[E.Suzaku]Adds", 0)
            end,
        
            onMobSpawn = function(mob)
			    mob:timer(15000, function(mobArg)
				    mob:useMobAbility(741) -- death
				end)
            end,
            
            onMobFight = function(mob, target)
            end,
            releaseIdOnDeath = true,
        
            -- You can apply mixins like you would with regular mobs. mixinOptions aren't supported yet.
            mixins =
            {
                require("scripts/mixins/rage"),
                require("scripts/mixins/job_special"),
            },
        
            -- The "whooshy" special animation that plays when Trusts or Dynamis mobs spawn
            specialSpawnAnimation = true,
        })
        
        -- Use the mob object as you normally would
        mob:setSpawn(randomPlayer:getXPos(), randomPlayer:getYPos(), randomPlayer:getZPos(), randomPlayer:getRotPos())
        mob:setDropID(0) -- No loot!
        mob:spawn()
        mob:updateClaim(randomPlayer)
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENFIRE)
end

entity.onMobDeath = function(mob, player, isKiller)
end

entity.onMobDespawn = function(mob)
end

return entity