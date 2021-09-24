### Title
Replacing CLuaBaseEntity::needToZone usage with local vars

### What was/is the problem?
The needToZone function is a generic method for determining if a player needs to zone, and this data persists through
logout until zoning clears it.  With the current implementation, this is stored in only one location, and does not tie
back to any quest, mission, or event requiring the zone.  The end result, is that any script executed within a zone
will all reference the same value, and this may cause issues between different scripts (see below example Wren provided
in the discussion forum)

> 
> * Alice is doing two separate questlines in Selbina.
> * In questline RED, there is a "must zone" requirement between quests RED-1 and RED-2 at Selbina NPC(R).
> * In questline BLUE, there is a "must zone" requirement between quests BLUE-1 and BLUE-2 at Selbina NPC(B).
> * Alice completes quest RED-1 and must now zone before acquiring RED-2 from the same NPC(R)
> * Alice zones out, which clears her needToZone flag.
> * Alice zones back in to Selbina.
> * Before Alice acquires RED-2, she completes quest BLUE-1 at NPC(B), and must now zone before acquiring BLUE-2.
> * She then returns to NPC(R), expecting to pick up RED-2, but now can't, because her needToZone flag has been set by the blue questline.
> 
> So using a localVar lets us handle the "needToZone" question distinctly within a given questline.  But it (probably) doesn't handle logout/login like retail.
> 
> While using needToZone (probably) handles logout/login like retail, but it uses a shared check across all questlines.

### What were/are the options?
1. Use LocalVars to associate a need to zone event with a specific task and allow logging out to reset this value
2. Store more data to associate a zone event with a specific quest, mission, or task
3. Use existing needToZone implementation, and not have association with any quest, mission, or task

### What was chosen?
Using LocalVars as a potential replacement for needToZone (Option 1)

The idea of having a correct needToZone option appears to outweigh the need to persist and require actual zone vs a logout.  This
doesn't mean we should just throw in localVars willy-nilly though!  Instead, a uniform standard should be used, that way in the case
of a future refactor (or if it is determined that we really, really need to not allow logout for certain things), that it can be
a drop-in replacement for existing work (See: Misc Notes)

### Misc Notes
Wrapper functions were created in the Interaction Framework container to create a uniform way of setting these variables, and
to serve as a middle layer should the method for storing this information change in the future.

```
-- These helper functions will set or get a localVar using varPrefix to determine
-- if zoning/logout is required.  There is no clearing support at this time, outside
-- of legitimate methods.
function Container:getMustZone(player)
    return player:getLocalVar(self.varPrefix .. "mustZone") == 1 and true or false
end

function Container:setMustZone(player)
    player:setLocalVar(self.varPrefix .. "mustZone", 1)
end

```

The resulting output of the above functions would create or get a variable in the following format, depending on which container
type the function is called from:
```
Mission[mission.areaId][mission.missionId]mustZone
Quest[quest.areaId][mission.missionId]mustZone
```
