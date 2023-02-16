----------------------------------------------------------------
-- Claim Shield Mixin
-- Used to add Claim Shield to a mob without overwriting
-- the onSpawn() function.
----------------------------------------------------------------

require("scripts/globals/mixins")
require("scripts/globals/utils")
require("scripts/globals/status")

g_mixins = g_mixins or {}

local claimshieldTime = 7500

-- Checks the list to see if the entry exists already
local listContains = function(list, element)
	for _,v in pairs(list) do
	  if v == element then
		return true
	  end
	end
	return false
end

-- Find the index for the given entry name
local findIndexForName = function(list, name)
    for index, entryName in ipairs(list) do
        if entryName == name then
            return index
        end
    end
    return nil
end

g_mixins.claim_shield = function(claimshieldMob)

    claimshieldMob:addListener("SPAWN", "CS_SPAWN", function(mob)
        mob:setClaimable(false)
        mob:setUnkillable(true)
        mob:setCallForHelpBlocked(true)
        mob:addStatusEffect(xi.effect.PHYSICAL_SHIELD, 999, 3, 9999)
        mob:addStatusEffect(xi.effect.MAGIC_SHIELD, 999, 3, 9999)
        mob:addStatusEffect(xi.effect.ARROW_SHIELD, 999, 3, 9999)
        mob:stun(claimshieldTime)

        mob:timer(claimshieldTime, function(mobArg)
            local enmityList = mobArg:getEnmityList()

            -- Filter so that pets will only count as a single entry along
            -- with their masters
            local entries = {}
            for _, v in pairs(enmityList) do
                local entity = v["entity"]
                local master = entity:getMaster()
				if entity:getObjType() ~= xi.objType.TRUST then
					local name = entity:getName()
					if
						not entity:isPC() and
						master and
						master:isPC()
					then
						name = master:getName()
					end
					if not listContains(entries,name) then
						table.insert(entries,name)
					end
				end
            end

            local numEntries = #entries

            -- Select a winner
			local winningNum = math.random(1, #entries)
			local winningName = "Carver"
			for index, entryName in ipairs(entries) do
				if index == winningNum then
					winningName = entryName
				end
			end
			
            local claimWinner = GetPlayerByName(winningName)
            if claimWinner then
                -- Message winner and their party/alliance that they've won
                local alliance = claimWinner:getAlliance()
                for _, member in pairs(alliance) do
                    local str = string.format("Your group has won the lottery for %s! (out of %i players)", mobArg:getName(), numEntries)
                    if #alliance == 1 then
                        str = string.format("You have won the lottery for %s! (out of %i players)", mobArg:getName(), numEntries)
                    end
                    member:PrintToPlayer(str, xi.msg.channel.SYSTEM_3, "")

                    -- Remove from entries table
                    local pos = findIndexForName(entries, member:getName())
                    if pos then
                        table.remove(entries, pos)
                    end
                end

                -- Everyone left in the entries table isn't part of the winning group, message them and
                -- clear them from the enmity list
                for _, member in pairs(entries) do
					memberEntity = GetPlayerByName(member)
                    local str = string.format("You were not successful in the lottery for %s. (out of %i players)", mobArg:getName(), numEntries)
                    memberEntity:PrintToPlayer(str, xi.msg.channel.SYSTEM_3, "")
					if memberEntity:getPet() ~= nil then
						memberEntity:getPet():disengage()
						mobArg:clearEnmityForEntity(memberEntity:getPet())
					end
					mobArg:disengage()
                    mobArg:clearEnmityForEntity(memberEntity)
                end
				
				-- Drop mods
				mobArg:setClaimable(true)
				mobArg:setUnkillable(false)
				mobArg:setCallForHelpBlocked(false)
				mobArg:resetAI()
				mobArg:delStatusEffectSilent(xi.effect.PHYSICAL_SHIELD)
				mobArg:delStatusEffectSilent(xi.effect.MAGIC_SHIELD)
				mobArg:delStatusEffectSilent(xi.effect.ARROW_SHIELD)
				mobArg:delStatusEffectsByFlag(0xFFFF)
				mobArg:setHP(mobArg:getMaxHP())
				
				-- Update Claim to winner
				mobArg:updateClaim(claimWinner)
            end
        end)
    end)
end

return g_mixins.claim_shield