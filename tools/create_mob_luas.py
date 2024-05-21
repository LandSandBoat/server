import sys
import os
from pathlib import Path
import dbtool

logging = True
sql_items = dict()
npc_items = dict()
errors = list()

local_path = dbtool.dbtool_dir_path

# Log function pull from price_checker.py and adjusted a bit
def log(message, *args):
    if logging:
        length = len(args)
        if length == 0:
            print(message)
        elif length == 2:
            print(message.format(args[0], args[1]))
        elif length == 3:
            print(message.format(args[0], args[1], args[2]))

settings, default_settings = dbtool.populate_settings()
dbtool.fetch_credentials()
dbtool.fetch_configs()
dbtool.fetch_versions()

if len(sys.argv) % 2 == 0:
    clobberFiles = sys.argv[1].lower() == "true"
    zoneWHERE = "1 = 1"
    familyWHERE = "1 = 1"
    mobskillWHERE = "1 = 1"
else:
    errors.append("Invalid number of arguments")

if len(errors) == 0:
    for i in range(2, len(sys.argv), 2):
        if sys.argv[i].lower() == "zone":
            zoneWHERE = "zoneid in (" + sys.argv[i + 1] + ")"
        elif sys.argv[i].lower() == "family":
            familyWHERE = "familyid in (" + sys.argv[i + 1] + ")"
        elif sys.argv[i].lower() == "mobskill":
            mobskillWHERE = "mob_skill_id in (" + sys.argv[i + 1] + ")"
        else:
            errors.append("Invalid argument pair: " + sys.argv[i] + " and " + sys.argv[i + 1])

if len(errors) == 0:
    query = f"""
    SELECT zoneid,zone_settings.name as zonename,mobname,familyid,skill_list_id
    FROM mob_pools left join mob_groups USING (poolid) LEFT JOIN zone_settings USING (zoneid)
    LEFT JOIN mob_spawn_points ON ((mob_spawn_points.mobid >> 12) & 0xFFF) = zoneid AND mob_groups.groupid = mob_spawn_points.groupid
    LEFT JOIN mob_skill_lists using (skill_list_id)
    LEFT JOIN mob_skills using (mob_skill_id)
    WHERE {zoneWHERE} AND {familyWHERE} AND {mobskillWHERE}
    AND NOT (pos_x = 0 AND pos_y = 0 AND pos_z = 0)
    GROUP BY mobname,zoneid;
    """
    log(query)
    result = dbtool.db_query(query).stdout.split("\n")

    if result == [""]:
        errors.append("No results found")

if len(errors) == 0:
    zoneNameIdx = result[0].split("\t").index("zonename")
    mobNameIdx = result[0].split("\t").index("mobname")
    for line in result[1:]:
        if line != "":
            try:
                line = line.split("\t")
                zoneName = line[zoneNameIdx]
                mobName = line[mobNameIdx]
                filePath = os.path.join(dbtool.server_dir_path, "scripts/zones/" + zoneName + "/mobs/" + mobName + ".lua")
                if os.path.exists(filePath) and not clobberFiles:
                    Path(filePath).touch()
                    log("Touching: " + filePath)
                else:
                    logPrefix = "Creating: "
                    if os.path.exists(filePath):
                        logPrefix = "Clobbering: "
                    fileContent = f"""-----------------------------------
-- Area: {zoneName.replace("_", " ")}
--  Mob: {mobName.replace("_", " ")}
-----------------------------------
local entity = {{}}

entity.onMobInitialize = function(mob)
end

entity.onMobSpawn = function(mob)
end

entity.onMobFight = function(mob, target)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
end

return entity
"""
                    with open(filePath, "w") as f:
                        f.write(fileContent)
                    log(logPrefix + filePath)
            except Exception as e:
                errors.append(e)

print("Found {0} errors".format(len(errors)))
for error in errors:
    print(error)
