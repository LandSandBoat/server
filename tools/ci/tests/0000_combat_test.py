import time


def test_name():
    return "Login"


def execute_test(cur, db, hxi_client):
    try:
        # Place near some Robber Crabs in Kuftal Tunnel
        cur.execute(
            "UPDATE chars SET \
            pos_zone = 174, \
            pos_prevzone = 174, \
            pos_x = 55, \
            pos_y = -9, \
            pos_z = -140 \
        WHERE charid = 1;"
        )
        # Set GodMode
        cur.execute(
            "INSERT INTO char_vars(charid, varname, value) VALUES(1, 'GodMode', 1);"
        )
        db.commit()

        hxi_client.login()
        # TODO: Parse incoming packets. (Analyze incoming damage, etc.)
        print("Sleeping 60s")
        time.sleep(60)
        hxi_client.logout()

        return True

    except Exception as e:
        return False
