package com.opensource.legosdk.plugin.volume

import android.content.Context
import com.opensource.legosdk.core.LGORequestable
import com.opensource.legosdk.core.LGOResponse
import android.content.Context.AUDIO_SERVICE
import android.media.AudioManager



/**
 * Created by cuiminghui on 2017/10/17.
 */
class LGOVolumeOperation(val request: LGOVolumeRequest): LGORequestable() {

    override fun requestSynchronize(): LGOResponse {
        request.context?.requestActivity()?.let { requestActivity ->
            val audioManager = requestActivity.getSystemService(Context.AUDIO_SERVICE) as? AudioManager
            audioManager?.let { audioManager ->
                val maxVolume = audioManager.getStreamMaxVolume(AudioManager.STREAM_MUSIC)
                request.volume?.let { volume ->
                    if (volume <= 1.0 && volume >= 0.0) {
                        audioManager.setStreamVolume(AudioManager.STREAM_MUSIC, (volume * maxVolume).toInt(), 0)
                    }
                }

            }
        }

        return LGOVolumeResponse().accept(null)
    }

    override fun requestAsynchronize(callbackBlock: (LGOResponse) -> Unit) {
        callbackBlock.invoke(requestSynchronize())
    }

}