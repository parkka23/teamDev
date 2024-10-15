function transliterateTextRuToEn(fieldId, start, end) {
    var messageField = document.getElementById(fieldId);
    var message = messageField.value;

    var selectedText = message.substring(start, end);
    if (selectedText.trim() !== '') {
        fetch('/message/translitRuToEn?text=' + encodeURIComponent(selectedText))
            .then(response => response.text())
            .then(data => {
                // Simulate undoable edit operation
                document.execCommand('selectAll', false, null);
                document.execCommand('insertText', false, message.substring(0, start) + data + message.substring(end));

                // Restore previous selection range
                messageField.setSelectionRange(start, start + data.length);
            })
            .catch(error => console.error('Error:', error));
    } else {
        alert('Please select text before transliterating.');
    }
}

function transliterateTextEnToRu(fieldId, start, end) {
    var messageField = document.getElementById(fieldId);
    var message = messageField.value;

    var selectedText = message.substring(start, end);
    if (selectedText.trim() !== '') {
        fetch('/message/translitEnToRu?text=' + encodeURIComponent(selectedText))
            .then(response => response.text())
            .then(data => {
                // Simulate undoable edit operation
                document.execCommand('selectAll', false, null);
                document.execCommand('insertText', false, message.substring(0, start) + data + message.substring(end));

                // Restore previous selection range
                messageField.setSelectionRange(start, start + data.length);
            })
            .catch(error => console.error('Error:', error));
    } else {
        alert('Please select text before transliterating.');
    }
}

// Convert selected text from EN to RU
function convertTextEnToRu(fieldId, start, end) {
    var messageField = document.getElementById(fieldId);
    var message = messageField.value;

    var selectedText = message.substring(start, end);
    if (selectedText.trim() !== '') {
        fetch('/message/convertEnToRu?text=' + encodeURIComponent(selectedText))
            .then(response => response.text())
            .then(data => {
                document.execCommand('selectAll', false, null);
                document.execCommand('insertText', false, message.substring(0, start) + data + message.substring(end));
                messageField.setSelectionRange(start, start + data.length);
            })
            .catch(error => console.error('Error:', error));
    } else {
        alert('Please select text before converting.');
    }
}

// Convert selected text from RU to EN
function convertTextRuToEn(fieldId, start, end) {
    var messageField = document.getElementById(fieldId);
    var message = messageField.value;

    var selectedText = message.substring(start, end);
    if (selectedText.trim() !== '') {
        fetch('/message/convertRuToEn?text=' + encodeURIComponent(selectedText))
            .then(response => response.text())
            .then(data => {
                document.execCommand('selectAll', false, null);
                document.execCommand('insertText', false, message.substring(0, start) + data + message.substring(end));
                messageField.setSelectionRange(start, start + data.length);
            })
            .catch(error => console.error('Error:', error));
    } else {
        alert('Please select text before converting.');
    }
}

// Add keydown event listener for shortcuts
document.addEventListener('keydown', function(event) {
    var activeElement = document.activeElement;
    if (activeElement.tagName === 'TEXTAREA' || (activeElement.tagName === 'INPUT' && activeElement.type === 'text')) {
        var fieldId = activeElement.id;
        var start = activeElement.selectionStart;
        var end = activeElement.selectionEnd;

        // Alt+T for transliteration
        if (event.altKey && event.code === 'KeyT' && !event.shiftKey) {
            event.preventDefault();
            transliterateTextRuToEn(fieldId, start, end);
        }
        // Alt+Shift+T for transliteration
        if (event.altKey && event.code === 'KeyT' && event.shiftKey) {
            event.preventDefault();
            transliterateTextEnToRu(fieldId, start, end);
        }

        // Alt+R for EN to RU conversion
        if (event.altKey && event.code === 'KeyR' && !event.shiftKey) {
            event.preventDefault();
            convertTextEnToRu(fieldId, start, end);
        }
        // Alt+Shift+R for RU to EN conversion
        if (event.altKey && event.code === 'KeyR' && event.shiftKey) {
            event.preventDefault();
            convertTextRuToEn(fieldId, start, end);
        }
    }
});