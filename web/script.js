// Function to check if the PWA is installed
function isPWAInstalled() {
  // Check if the PWA is running in standalone mode or installed
  return window.matchMedia('(display-mode: standalone)').matches || window.navigator.standalone || false;
}

// Function to check if the user is on iOS
function isIOS() {
  return /iPad|iPhone|iPod/.test(navigator.userAgent) && !window.MSStream;
}

// Detect if the user is on iOS and if the PWA is installed
window.addEventListener('load', () => {
  if (isIOS()) {
    console.log('User is on iOS');
    
    if (isPWAInstalled()) {
      // The PWA is installed on iOS
      console.log('PWA is already installed');
    } else {
      // PWA is not installed on iOS, show installation instructions
      console.log('PWA is not installed, showing installation instructions');
      //showIosInstructions();
    }
  } else {
    console.log('User is not on iOS');
    
    // Handle installation for non-iOS (e.g., Android)
    if (!isPWAInstalled() && isDeferredNotNull()) {
      presentAddToHome();
    }
    
  }
});

// Function to show iOS-specific instructions for installing the PWA
// function showIosInstructions() {
//   alert('To install this app on your iPhone or iPad, tap the "Share" icon and then "Add to Home Screen".');
// }

// Function to check if the deferredPrompt is not null (For Android devices)
function isDeferredNotNull() {
  return deferredPrompt != null;
}

// Listen for the beforeinstallprompt event (This is Android specific)
let deferredPrompt;
window.addEventListener('beforeinstallprompt', (e) => {
  e.preventDefault();
  deferredPrompt = e;
  console.log('beforeinstallprompt event fired and deferredPrompt is set.');
});

// Function to present the Add to Home Screen prompt (For Android)
function presentAddToHome() {
  if (deferredPrompt) {
    deferredPrompt.prompt();
    deferredPrompt.userChoice.then((choiceResult) => {
      if (choiceResult.outcome === 'accepted') {
        console.log('User accepted the Add to Home Screen prompt');
      } else {
        console.log('User dismissed the Add to Home Screen prompt');
      }
      deferredPrompt = null;
    });
  } else {
    console.log('deferredPrompt is null. Cannot present Add to Home Screen prompt.');
  }
}
