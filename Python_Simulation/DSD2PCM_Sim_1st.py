# -*- coding: utf-8 -*-
"""
Created on Thu Dec 16 00:35:38 2021

@author: AUDIY
"""

import numpy as np
import scipy.signal as signal
import matplotlib.pyplot as plt

# 1st-order Pulse Density Modulation
def PDM(x, nbits):
    qe = 0 # Quantization Error
    y = np.zeros(np.shape(x)[0]) # Return Array
    
    # Modulation
    for i in range(np.shape(x)[0]):
        if x[i] >= qe:
            y[i] = 1
        else:
            y[i] = 0
         
        # Maximize the Modulated Signal to PCM max Amplitude
        yi_Analog = np.floor((((y[i]*2 - 1) + 1)/2) * (2**nbits - 1) + 0.5) \
            - (2 ** (nbits-1))
        
        # Calcurate the Quantization Error
        qe = qe + (yi_Analog - x[i])
        
    return y.astype(int), qe


# float to Linear PCM Conversion
def LPCM(x, nbits):
    #xmax = np.max(x) # Maximum float Amplitude
    xmax = 1
    #xmin = np.min(x) # Minimum float Amplitude
    xmin = -1
    
    # Quantization
    x_LPCM = np.floor(((x - xmin)/(xmax - xmin)) * (2 ** nbits - 1) + 0.5) \
        - (2 ** (nbits-1))
    
    return x_LPCM.astype(int)


# Zero-order Hold Linear PCM Upsampling
def ZeroOrderHold(xPCM, OSR):
    y = signal.upfirdn(np.ones(OSR), xPCM, OSR)
    
    return y


# Main Entry Point
if __name__ == "__main__":
    
    # PCM parameters
    fs_PCM = 44100 # Sampling frequency
    nbits = 16 # Quantization Bits
    
    # DSD Parameters
    OSR = 64 # DSD vs PCM sampling frequency ratio
    fs_DSD = fs_PCM * OSR # DSD Sampling frequency
    
    # Time Plots
    t_length = 1 # Time length (sec)
    t = np.arange(0, 1, 1/fs_PCM)
    
    # Reference Analog Signal (Amplitude Range = [-1, 1])
    f = 1000 # Frequency
    x = np.sin(2 * np.pi * 1000 * t) # float Sine wave
    #x = np.zeros(fs_PCM) # Mute Data
    
    # Analog to Linear PCM conversion
    x_LPCM = LPCM(x, nbits)
    
    # Zero Order Hold to Convert DSD
    x_LPCM_Hold = ZeroOrderHold(x_LPCM, OSR)
    
    # Convert PCM to DSD
    y_DSD, qe = PDM(x_LPCM_Hold, nbits)

    
    # Plot the filtered DSD Signal, Normalized PCM and DSD Signal
    y_filtered = signal.upfirdn(np.ones(10), y_DSD) #Moving Average Filter
    y_filtered = y_filtered/np.max(y_filtered) # Normalize
    plt.figure()
    plt.plot(np.arange(0, 1, 1/fs_DSD)[0:2822], y_DSD[0:2822] * 2 - 1, label="DSD") # DSD
    plt.plot(np.arange(0, 1, 1/fs_DSD)[0:2822], y_filtered[0:2822] * 2 - 1, label="Filtered DSD") # Filtered Data
    plt.plot(np.arange(0, 1, 1/fs_DSD)[0:2822], x_LPCM_Hold[0:2822]/np.max(x_LPCM_Hold), label="PCM") # PCM
    plt.legend(loc="upper right")
    plt.xlabel("Time [s]")
    plt.ylabel("Normalized Amplitude")
    