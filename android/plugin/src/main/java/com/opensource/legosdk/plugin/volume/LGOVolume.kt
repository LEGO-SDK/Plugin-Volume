package com.opensource.legosdk.plugin.volume

import com.opensource.legosdk.core.*
import org.json.JSONObject

class LGOVolume: LGOModule() {

    override fun buildWithJSONObject(obj: JSONObject, context: LGORequestContext): LGORequestable? {
        val request = LGOVolumeRequest(context)
        request.volume = obj.optDouble("volume", 0.0)
        return LGOVolumeOperation(request)
    }

}