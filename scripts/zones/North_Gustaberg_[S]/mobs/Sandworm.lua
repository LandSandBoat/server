-----------------------------------
-- Area: North Gustaberg [S]
--  Mob: Sandworm
-- Note:  Title Given if Sandworm does not Doomvoid
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob,player)
    mob:setMod(xi.mod.DEF, 400)
    mob:setMod(xi.mod.MEVA, 300)
    mob:setMod(xi.mod.MDEF, 50)
	mob:setMod(xi.mod.DOUBLE_ATTACK, 20)

 	local random = 0
 	random = math.random(10)

 	if (random <=7) then
    mob:setLocalVar('GuivreFight', 1)
 	end
 	if (random >=8) then
 	mob:setLocalVar('LambtonWormFight', 3)
 	end
					
	SetServerVariable('[SW_DESPAWN]unclaimed', 0)
	mob:setLocalVar('[DESPAWN]timer',GetSystemTime() + 3600)
	
end
	----------------------------------------
	-- Despawn every hour and repop in another zone
	-- Currently an immediate respawn
	----------------------------------------
entity.onMobRoam = function (mob)
	if GetSystemTime() >= mob:getLocalVar('[DESPAWN]timer') then
		SetServerVariable('[SW_DESPAWN]unclaimed', 1)
		DespawnMob(mob:getID())
	end
end

entity.onMobWeaponSkill = function(target,mob,skill)
end

entity.onMobDeath = function(mob, player, isKiller)
    player:addTitle(xi.title.SANDWORM_WRANGLER)
end

entity.onMobDespawn = function(mob)
	local mobids = {
		17109357, --East Ron
		17138041, --North Gusta
		17166720, --West Saruta
		17178901, --Sauromugue
		17150317, --Rolanberry
		17174888} --Meriphataud
	
	if GetServerVariable('[SW_DESPAWN]unclaimed') == 1 then
		local wait = math.random(10, 60) -- Repop within a minute
		local AREA = mobids[math.random(1, #mobids)]

		SetServerVariable('[POP]SANDWORM_ZONE', AREA)
		SetServerVariable('[POP]SANDWORM', GetSystemTime() + wait)
		UpdateNMSpawnPoint(mob:getID())
	else
		local wait = math.random(72000, 90000) -- Standard respawn time
		local AREA = mobids[math.random(1, #mobids)]

		SetServerVariable('[POP]SANDWORM_ZONE', AREA)
		SetServerVariable('[POP]SANDWORM', GetSystemTime() + wait)
		UpdateNMSpawnPoint(mob:getID())

	end
end

return entity
