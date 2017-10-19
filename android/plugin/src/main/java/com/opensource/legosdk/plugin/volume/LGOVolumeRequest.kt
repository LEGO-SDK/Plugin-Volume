package com.opensource.legosdk.plugin.volume

import com.opensource.legosdk.core.LGORequest
import com.opensource.legosdk.core.LGORequestContext

/**
 * Created by cuiminghui on 2017/10/17.
 */

class LGOVolumeRequest(context: LGORequestContext?) : LGORequest(context) {

    var volume: Double? = null

}